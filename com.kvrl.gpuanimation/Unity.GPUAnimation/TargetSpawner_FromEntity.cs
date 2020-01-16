using Unity.Entities;
using Unity.Mathematics;
using UnityEngine;

public struct TargetSpawner_FromEntity : IComponentData
{
    public Entity Prefab;
}

public struct ValidFloat3
{
    public static implicit operator float3(ValidFloat3 v) { return v.Valid ? v.Value : 0; }
    public static implicit operator ValidFloat3(float3 f) { return new ValidFloat3 { Value = f, Valid = true }; }
    public static implicit operator ValidFloat3(Vector3 f) { return new ValidFloat3 { Value = f, Valid = true }; }

    public float3 Value;
    public bool Valid;
}

[InternalBufferCapacity(100)]
public struct PositionBufferElement : IBufferElementData
{
    public static implicit operator float3(PositionBufferElement e) { return e.Value; }
    public static implicit operator PositionBufferElement(Vector3 v) { return new PositionBufferElement { Value = v }; }
    public static implicit operator PositionBufferElement(float3 f) { return new PositionBufferElement { Value = f }; }

    public float3 Value;
}

/// <summary>
/// A Dynamic Buffer with Transform data
/// </summary>
/// <remarks>
/// To pass arrays of data to an ECS Job, we need to do so as part of a DynamicBuffer. The buffer's max capacity must be fixed,
/// since memory layouts must be known in advance for ECS to optimize data processing.
/// A DynamicBuffer is templated, so what we gotta do is define the struct that will contain the data we need.
/// The struct must implement IBufferElementData
/// </remarks>
[InternalBufferCapacity(100)] // Mark the buffer as containing max 100 elements
public struct TransformBufferElement : IBufferElementData
{
    // Define implicit conversions for convenience
    public static implicit operator TransformBufferElement(Transform t)
    {
        float s = math.max(math.max(t.localScale.x, t.localScale.y), t.localScale.z);

        return new TransformBufferElement
        {
            Position = t.position,
            Rotation = t.rotation,
            Scale = s
        };
    }

    // Define the data in our BufferElement
    public float3 Position;
    public quaternion Rotation;
    public float Scale;
}




