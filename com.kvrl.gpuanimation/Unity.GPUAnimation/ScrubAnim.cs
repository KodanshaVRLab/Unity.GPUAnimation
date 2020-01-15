using Unity.Burst;
using Unity.Entities;
using Unity.Jobs;
using UnityEngine;
using Unity.GPUAnimation;
using Unity.Mathematics;

struct ScrubAnim : IComponentData
{
    public int ClipIndex;
    public float Time;
    public float Offset;
    public float Duration;
    public bool IsFirstFrame;
}

[UpdateInGroup(typeof(PresentationSystemGroup))]
[UpdateBefore(typeof(CalculateTextureCoordinateSystem))]
public class SrubAnimSystem : JobComponentSystem
{
    [BurstCompile]
    struct ScrubAnimJob : IJobForEachWithEntity<ScrubAnim, GPUAnimationState>
    {
        public void Execute(Entity entity, int index, ref ScrubAnim scrub, ref GPUAnimationState animstate)
        {
            animstate.AnimationClipIndex = scrub.ClipIndex;

            ref var clips = ref animstate.AnimationClipSet.Value.Clips;
            if ((uint)animstate.AnimationClipIndex < (uint)clips.Length)
            {
                animstate.Time = math.saturate((scrub.Time - scrub.Offset) / scrub.Duration);
                //animstate.Time = math.frac(animstate.Time + 0.01f);
            }
            else
            {
                // @TODO: Warnings?
            }
        }
    }

    protected override JobHandle OnUpdate(JobHandle inputDeps)
    {
        return new ScrubAnimJob().Schedule(this, inputDeps);
    }
}
