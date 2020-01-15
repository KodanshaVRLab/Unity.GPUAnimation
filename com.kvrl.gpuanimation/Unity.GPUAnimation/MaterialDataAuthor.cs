using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Burst;
using Unity.Entities;
using Unity.Jobs;
using Unity.GPUAnimation;
using Unity.Mathematics;

using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Transforms;
using UnityEngine.Profiling;
using UnityEngine.Rendering;



[System.Serializable]
public struct SharedMaterialData : ISharedComponentData, IEquatable<SharedMaterialData>
{
    public Material Material;

    public bool Equals(SharedMaterialData other)
    {
        return Material == other.Material;
    }

    public override int GetHashCode()
    {
        unchecked
        {
            var hashCode = (ReferenceEquals(Material, null) ? 0 : Material.GetHashCode());
            return hashCode;
        }
    }
}

//public struct MaterialData : IComponentData
//{
//    public Material Material;
//}

public class MaterialDataAuthor : MonoBehaviour, IConvertGameObjectToEntity
{
    public void Convert(Entity entity, EntityManager dstManager, GameObjectConversionSystem conversionSystem)
    {
        Renderer r = GetComponentInChildren<Renderer>();

        if (r != null)
        {
            dstManager.AddSharedComponentData(entity, new SharedMaterialData
            {
                Material = r.sharedMaterial
            });
        }
    }
}
