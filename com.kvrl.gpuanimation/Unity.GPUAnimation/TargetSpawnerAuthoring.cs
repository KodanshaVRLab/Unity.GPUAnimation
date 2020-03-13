using System.Collections;
using System.Collections.Generic;
using Unity.Entities;
using Unity.Mathematics;
using UnityEngine;

namespace Unity.GPUAnimation
{
    [RequiresEntityConversion]
    public class TargetSpawnerAuthoring : MonoBehaviour, IDeclareReferencedPrefabs, IConvertGameObjectToEntity
    {
        public GameObject Prefab;
        public Transform[] Targets;

        public void DeclareReferencedPrefabs(List<GameObject> gameObjects)
        {
            gameObjects.Add(Prefab);
        }

        public void Convert(Entity entity, EntityManager dstManager, GameObjectConversionSystem conversionSystem)
        {
            List<float3> pos = new List<float3>();

            var data = new TargetSpawner_FromEntity
            {
                Prefab = conversionSystem.GetPrimaryEntity(Prefab),
            };


            dstManager.AddComponentData(entity, data);

            dstManager.AddBuffer<TransformBufferElement>(entity);
            dstManager.AddBuffer<ScrubDataBufferElement>(entity);
            dstManager.AddBuffer<ScrubPropertyBufferElement>(entity);

            var transforms = dstManager.GetBuffer<TransformBufferElement>(entity);
            var anims = dstManager.GetBuffer<ScrubDataBufferElement>(entity);
            var props = dstManager.GetBuffer<ScrubPropertyBufferElement>(entity);

            ScrubAnimAuthoring s;
            ScrubMaterialPropertyAuthor p;
            Transform t;
            for (int i = 0; i < Targets.Length; ++i)
            {
                t = Targets[i];
                //pos.Add(t.position);

                if (!t.gameObject.activeSelf)
                {
                    continue;
                }

                transforms.Add(t);

                if (t.TryGetComponent<ScrubAnimAuthoring>(out s))
                {
                    anims.Add(s.Data);
                }

                if (t.TryGetComponent<ScrubMaterialPropertyAuthor>(out p))
                {
                    props.Add(p.Data);
                }
            }
        }
    }
}
