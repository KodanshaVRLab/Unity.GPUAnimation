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
    public float2 ClampRange;
    public bool Loop;
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
            int idx = animstate.AnimationClipIndex;
            if (idx < clips.Length)
            {
                animstate.Time = (scrub.Time - scrub.Offset) / scrub.Duration;
                
                // Unity's core system handles Time as absolute, not normalized!
                // if (scrub.Loop) {
                //     animstate.Time = math.frac(animstate.Time + 0.01f);
                // } else {
                //     animstate.Time = math.clamp(animstate.Time, scrub.ClampRange.x, scrub.ClampRange.y);
                // }

                // HACK: For whatever reason core isn't reading Clip loop so let's loop ourselves?
                if (scrub.Loop) {
                    float len = clips[idx].AnimationLength;
                    animstate.Time = Mathf.Repeat(animstate.Time, len);
                }
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
