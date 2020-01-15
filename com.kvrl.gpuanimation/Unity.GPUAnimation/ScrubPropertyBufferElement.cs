using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using Unity.Entities;
using Unity.Mathematics;

/// <summary>
/// A Dynamic Buffer with ScrubMaterialProperty data
/// </summary>
/// <remarks>
/// Note that by using two separate types, we can have the same data layout be applied differently to different systems
/// </remarks>
[InternalBufferCapacity(100)]
public struct ScrubPropertyBufferElement : IBufferElementData
{
    public float Offset;
    public float Duration;
    public int PropertyID;
}
