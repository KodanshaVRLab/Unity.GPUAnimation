using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Collections;
using Unity.Entities;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Transforms;

[UpdateInGroup(typeof(SimulationSystemGroup))]
public class ScrubAnimAutoSystem : JobComponentSystem
{
    struct UpdaterJob : IJobForEachWithEntity<ScrubAnim>
    {
        public float Time;

        public void Execute(Entity entity, int index, ref ScrubAnim anim)
        {
            anim.Time = math.frac(anim.Time + 0.01f);
        }
    }

    protected override JobHandle OnUpdate(JobHandle inputDeps)
    {
        return new UpdaterJob().Schedule(this, inputDeps);
    }
}
