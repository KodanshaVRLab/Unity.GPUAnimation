using Unity.Collections;
using Unity.Entities;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Transforms;

// JobComponentSystems can run on worker threads.
// However, creating and removing Entities can only be done on the main thread to prevent race conditions.
// The system uses an EntityCommandBuffer to defer tasks that can't be done inside the Job.

// ReSharper disable once InconsistentNaming
namespace Unity.GPUAnimation
{
    [UpdateInGroup(typeof(SimulationSystemGroup))]
    public class TargetSpawnerSystem : JobComponentSystem
    {
        // BeginInitializationEntityCommandBufferSystem is used to create a command buffer which will then be played back
        // when that barrier system executes.
        // Though the instantiation command is recorded in the SpawnJob, it's not actually processed (or "played back")
        // until the corresponding EntityCommandBufferSystem is updated. To ensure that the transform system has a chance
        // to run on the newly-spawned entities before they're rendered for the first time, the SpawnerSystem_FromEntity
        // will use the BeginSimulationEntityCommandBufferSystem to play back its commands. This introduces a one-frame lag
        // between recording the commands and instantiating the entities, but in practice this is usually not noticeable.
        BeginInitializationEntityCommandBufferSystem m_EntityCommandBufferSystem;

        protected override void OnCreate()
        {
            // Cache the BeginInitializationEntityCommandBufferSystem in a field, so we don't have to create it every frame
            m_EntityCommandBufferSystem = World.GetOrCreateSystem<BeginInitializationEntityCommandBufferSystem>();
        }

        [RequireComponentTag(typeof(TransformBufferElement), typeof(ScrubDataBufferElement))]
        struct SpawnJob : IJobForEachWithEntity<TargetSpawner_FromEntity, LocalToWorld>
        {
            public EntityCommandBuffer.Concurrent CommandBuffer;

            [NativeDisableParallelForRestriction]
            public BufferFromEntity<TransformBufferElement> Transforms;
            [NativeDisableParallelForRestriction]
            public BufferFromEntity<ScrubDataBufferElement> Anims;
            [ReadOnly]
            public BufferFromEntity<ScrubPropertyBufferElement> Props;

            public void Execute(Entity entity, int index, [ReadOnly] ref TargetSpawner_FromEntity spawner,
                [ReadOnly] ref LocalToWorld location)
            {
                DynamicBuffer<TransformBufferElement> transformBuffer = Transforms[entity];
                DynamicBuffer<ScrubDataBufferElement> animBuffer = Anims[entity];
                DynamicBuffer<ScrubPropertyBufferElement> propBuffer = Props[entity];

                TransformBufferElement t;
                ScrubDataBufferElement s;
                ScrubPropertyBufferElement p;

                for (int i = 0; i < transformBuffer.Length; ++i)
                {
                    var instance = CommandBuffer.Instantiate(index, spawner.Prefab);
                    t = transformBuffer[i];
                    // TODO: Ensure equal length / handle missing component data
                    s = animBuffer[i];
                    p = propBuffer[i];

                    CommandBuffer.SetComponent(index, instance, new Translation { Value = t.Position });
                    CommandBuffer.SetComponent(index, instance, new Rotation { Value = t.Rotation });
                    CommandBuffer.AddComponent<Scale>(index, instance, new Scale { Value = t.Scale });
                    //CommandBuffer.SetComponent(index, instance, new Scale { Value = t.Scale });
                    CommandBuffer.SetComponent(index, instance, new ScrubAnim
                    {
                        ClipIndex = s.ClipIndex,
                        Time = 0,
                        Offset = s.Offset,
                        Duration = s.Duration,
                        ClampRange = s.ClampRange
                    });
                    CommandBuffer.SetComponent(index, instance, new ScrubMaterialProperty
                    {
                        Value = 0,
                        Offset = p.Offset,
                        Duration = p.Duration,
                        PropertyID = p.PropertyID
                    });
                }

                CommandBuffer.DestroyEntity(index, entity);
            }
        }

        protected override JobHandle OnUpdate(JobHandle inputDeps)
        {
            //Instead of performing structural changes directly, a Job can add a command to an EntityCommandBuffer to perform such changes on the main thread after the Job has finished.
            //Command buffers allow you to perform any, potentially costly, calculations on a worker thread, while queuing up the actual insertions and deletions for later.

            // Schedule the job that will add Instantiate commands to the EntityCommandBuffer.
            var job = new SpawnJob
            {
                CommandBuffer = m_EntityCommandBufferSystem.CreateCommandBuffer().ToConcurrent(),
                Transforms = GetBufferFromEntity<TransformBufferElement>(true),
                Anims = GetBufferFromEntity<ScrubDataBufferElement>(true),
                Props = GetBufferFromEntity<ScrubPropertyBufferElement>(true)
            }.Schedule(this, inputDeps);


            // SpawnJob runs in parallel with no sync point until the barrier system executes.
            // When the barrier system executes we want to complete the SpawnJob and then play back the commands (Creating the entities and placing them).
            // We need to tell the barrier system which job it needs to complete before it can play back the commands.
            m_EntityCommandBufferSystem.AddJobHandleForProducer(job);

            return job;
        }
    }
}
