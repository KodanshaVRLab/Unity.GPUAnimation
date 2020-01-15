// #if !defined(UNIVERSAL_PIPELINE_CORE_INCLUDED) && !defined(LIGHTWEIGHT_PIPELINE_CORE_INCLUDED)

// #define _Time _NotTime
// #define _SinTime _NotSinTime
// #define _CosTime _NotCosTime
// #define unity_DeltaTime ugh1
// #define _TimeParameters ugh2

#ifdef SHADERGRAPH_PREVIEW
    #define UNIVERSAL_SHADER_VARIABLES_INCLUDED
#else
#endif

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"

// #define UNITY_INSTANCING_PROCEDURAL_FUNC setup_gpuanimation
#ifdef SHADERGRAPH_PREVIEW
    #undef UNIVERSAL_SHADER_VARIABLES_INCLUDED

    #define UNITY_ANY_INSTANCING_ENABLED 0
#endif


// #undef _Time
// #undef _SinTime
// #undef _CosTime
// #undef unity_DeltaTime
// #undef _TimeParameters

// #endif


// #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonMaterial.hlsl"
// #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"
#include "Packages/com.kvrl.gpuanimation/Shaders/GPUAnimationLWRP.hlsl"

void Setup_GPUAnimation_float (out float Dummy, out float4x4 ObjectToWorld, out float4x4 WorldToObject) {
    // #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
    #if !defined(SHADERGRAPH_PREVIEW) && defined(UNITY_PROCEDURAL_INSTANCING_ENABLED)
    // Modify Unity-given matrices
        // Construct an identity matrix
    unity_ObjectToWorld = float4x4(1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1);
    unity_WorldToObject = unity_ObjectToWorld;

    unity_WorldToObject._14_24_34 *= -1;
    unity_WorldToObject._11_22_33 = 1.0f / unity_WorldToObject._11_22_33;

    Dummy = 1;
    ObjectToWorld = unity_ObjectToWorld;
    WorldToObject = unity_WorldToObject;
#else
    Dummy = 1;
    ObjectToWorld = unity_ObjectToWorld;
    WorldToObject = unity_WorldToObject;
#endif
}

void Position_GPUAnimation_float (float3 PositionOS, float2 BoneIds, float2 BoneInfluences,
    out float3 PositionWS, out float3 PositionVS, out float4 PositionCS, out float4 PositionNDC
) {
    VertexPositionInputs o = GetVertexPositionInputs_GPUAnimation(PositionOS, BoneIds, BoneInfluences);

    PositionWS = o.positionWS;
    PositionVS = o.positionVS;
    PositionCS = o.positionCS;
    PositionNDC = o.positionNDC;
}

void DebugGPUAnimationTextures_float (float2 UV, out float4 Tex0, out float4 Tex1, out float4 Tex2) {
    Tex0 = 0;
    Tex1 = 0;
    Tex2 = 0;

    #ifndef SHADERGRAPH_PREVIEW

        Tex0 = tex2Dlod(_AnimationTexture0, float4(UV, 0, 0));
        Tex1 = tex2Dlod(_AnimationTexture1, float4(UV, 0, 0));
        Tex2 = tex2Dlod(_AnimationTexture2, float4(UV, 0, 0));

    #endif
}