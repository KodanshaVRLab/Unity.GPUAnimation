using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Entities;
using Unity.Mathematics;
namespace Unity.GPUAnimation
{
    public class ScrubMaterialPropertyAuthor : MonoBehaviour, IConvertGameObjectToEntity
    {
        [Range(0, 1)]
        public float Offset = 0f;
        [Range(0, 1)]
        public float Duration = 1f;
        public string Property = "_Value";
        int PropertyID = -1;

        public bool dataOnly = false;

        public ScrubPropertyBufferElement Data
        {
            get
            {
                return new ScrubPropertyBufferElement
                {
                    PropertyID = PropertyID,
                    Offset = Offset,
                    Duration = Duration
                };
            }
        }

        private void Awake()
        {
            PropertyID = Shader.PropertyToID(Property);
        }

        public void Convert(Entity entity, EntityManager dstManager, GameObjectConversionSystem conversionSystem)
        {
            if (dataOnly)
            {
                return;
            }

            if (PropertyID == -1)
            {
                PropertyID = Shader.PropertyToID(Property);
            }

            ScrubMaterialProperty data = new ScrubMaterialProperty
            {
                PropertyID = this.PropertyID,
                Value = 0,
                Offset = this.Offset,
                Duration = this.Duration
            };

            dstManager.AddComponentData(entity, data);
        }
    }
}