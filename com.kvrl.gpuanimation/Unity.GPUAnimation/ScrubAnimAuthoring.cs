using System.Collections;
using System.Collections.Generic;
using Unity.Entities;
using Unity.Mathematics;
using UnityEngine;

namespace Unity.GPUAnimation
{
    public class ScrubAnimAuthoring : MonoBehaviour, IConvertGameObjectToEntity
    {
        [Range(0, 1)]
        public float time = 0f;
        [Range(0, 1)]
        public float offset = 0f;
        [Range(0, 1)]
        public float duration = 1f;
        public int ClipIndex = 0;
        public Scrubber scrubber;

        public bool dataOnly = false;

        Entity entity;

        public ScrubDataBufferElement Data
        {
            get
            {
                return new ScrubDataBufferElement
                {
                    Offset = offset,
                    Duration = duration,
                    ClipIndex = this.ClipIndex
                };
            }
        }

        public void Convert(Entity entity, EntityManager dstManager, GameObjectConversionSystem conversionSystem)
        {
            dstManager.AddComponentData(entity, new ScrubAnim
            {
                ClipIndex = ClipIndex,
                Time = time,
                IsFirstFrame = true,
                Offset = offset,
                Duration = duration
            });

            this.entity = entity;

            if (scrubber)
            {
                scrubber.Link(entity);
                for (int i = transform.childCount - 1; i >= 0; --i)
                {
                    Destroy(transform.GetChild(i).gameObject);
                }
            }

        }

        private void Update()
        {
            if (!scrubber && !dataOnly)
            {
                var data = World.Active.EntityManager.GetComponentData<ScrubAnim>(entity);
                data.Time = time;
                World.Active.EntityManager.SetComponentData<ScrubAnim>(entity, data);
            }
        }
    }
}
