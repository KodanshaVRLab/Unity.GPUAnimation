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

    public struct ScrubMaterialProperty : IComponentData
    {
        public int PropertyID;
        public float Value;
        public float Offset;
        public float Duration;
    }


    [UpdateInGroup(typeof(SimulationSystemGroup))]
    public class ScrubMaterialPropertySystem : JobComponentSystem
    {
        public static Scrubber scrubber = null;
        List<SharedMaterialData> materials = new List<SharedMaterialData>();
        BufferFromEntity<ScrubPropertyBufferElement> scrubs;

        EntityQuery query;

        static int TestID = -1;

        struct UpdaterJob : IJobForEachWithEntity<ScrubMaterialProperty>
        {
            //public Material mat;
            //public float Value;

            public void Execute(Entity entity, int index, ref ScrubMaterialProperty scrub)
            {
                //if (scrubber != null)
                //{


                scrub.Value = math.saturate((scrubber.time - scrub.Offset) / scrub.Duration);
                //}
            }
        }

        protected override void OnCreate()
        {
            query = GetEntityQuery(ComponentType.ReadOnly<SharedMaterialData>(), ComponentType.ReadOnly<ScrubMaterialProperty>());
            TestID = Shader.PropertyToID("_Value");
        }

        protected override JobHandle OnUpdate(JobHandle inputDeps)
        {
            //materials.Clear();
            //EntityManager.GetAllUniqueSharedComponentData(materials);

            //foreach (SharedMaterialData mat in materials)
            //{
            //    if (mat.Material == null)
            //    {
            //        continue;
            //    }

            //    query.SetSharedComponentFilter(mat);

            //    mat.Material.SetFloat(TestID, math.frac(Time.time));
            //    if (scrubber)
            //    {
            //    }
            //}

            //return inputDeps;

            return new UpdaterJob().Schedule(this, inputDeps);
        }
    }
}

