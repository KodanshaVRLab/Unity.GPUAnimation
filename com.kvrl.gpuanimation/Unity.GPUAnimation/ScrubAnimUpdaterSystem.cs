using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Collections;
using Unity.Entities;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Transforms;

namespace Unity.GPUAnimation
{
    [UpdateInGroup(typeof(SimulationSystemGroup))]
    public class ScrubAnimUpdaterSystem : JobComponentSystem
    {
        public static Scrubber scrub = null;

        struct UpdaterJob : IJobForEachWithEntity<ScrubAnim>
        {
            public float Time;

            public void Execute(Entity entity, int index, ref ScrubAnim anim)
            {
                if (scrub)
                {
                    anim.Time = this.Time;
                }
            }
        }

        protected override JobHandle OnUpdate(JobHandle inputDeps)
        {
            float t = scrub != null ? scrub.time : 0f;

            return new UpdaterJob { Time = t }.Schedule(this, inputDeps);
        }
    }
}
