Shader "Test/GPU Anim With Material Property"
{
    Properties
    {
        // _Value("Value", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "Queue"="Transparent+0"
        }
        
        Pass
        {
            Name "Pass"
            Tags 
            { 
                // LightMode: <None>
            }
           
            // Render State
            Blend One Zero, One Zero
            Cull Back
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
            #pragma instancing_options procedural:setup_gpuanimation

        
            // Keywords
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma shader_feature _ _SAMPLE_GI

            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_TEXCOORD1
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_UNLIT
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
                float _Dumb;
                float _Value[100];
            CBUFFER_END
            // UNITY_INSTANCING_BUFFER_START(Props)
            //     UNITY_DEFINE_INSTANCED_PROP(float, _Value)
            // UNITY_INSTANCING_BUFFER_END(Props)
            float Vector1_6CC10AE3;
        
            // Graph Functions
            
            // ec0ff9673c9253f0f0a3b714ae17e4d4
            #include "Packages/com.kvrl.gpuanimation/Shaders/GPUAnimation_ShaderGraph.hlsl"
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            struct Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc
            {
            };
            
            void SG_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc(float3 Vector3_B360E246, float2 Vector2_354F2D33, float2 Vector2_14A95160, Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc IN, out float3 WorldSpace_1, out float3 ViewSpace_2, out float4 ClipSpace_3, out float4 NormalizedDevice_4)
            {
                float3 _Property_DC617EF3_Out_0 = Vector3_B360E246;
                float2 _Property_9A45716B_Out_0 = Vector2_354F2D33;
                float2 _Property_A68BECEF_Out_0 = Vector2_14A95160;
                float3 _CustomFunction_A1E2AF63_PositionWS_3;
                float3 _CustomFunction_A1E2AF63_PositionVS_4;
                float4 _CustomFunction_A1E2AF63_PositionCS_5;
                float4 _CustomFunction_A1E2AF63_PositionNDC_6;
                Position_GPUAnimation_float(_Property_DC617EF3_Out_0, _Property_9A45716B_Out_0, _Property_A68BECEF_Out_0, _CustomFunction_A1E2AF63_PositionWS_3, _CustomFunction_A1E2AF63_PositionVS_4, _CustomFunction_A1E2AF63_PositionCS_5, _CustomFunction_A1E2AF63_PositionNDC_6);
                WorldSpace_1 = _CustomFunction_A1E2AF63_PositionWS_3;
                ViewSpace_2 = _CustomFunction_A1E2AF63_PositionVS_4;
                ClipSpace_3 = _CustomFunction_A1E2AF63_PositionCS_5;
                NormalizedDevice_4 = _CustomFunction_A1E2AF63_PositionNDC_6;
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 WorldSpaceTangent;
                float3 ObjectSpaceBiTangent;
                float3 WorldSpaceBiTangent;
                float3 ObjectSpacePosition;
                float4 uv1;
                float4 uv2;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float _CustomFunction_B8A2C269_Dummy_0;
                float4x4 _CustomFunction_B8A2C269_OtW_1;
                float4x4 _CustomFunction_B8A2C269_WtO_2;
                Setup_GPUAnimation_float(_CustomFunction_B8A2C269_Dummy_0, _CustomFunction_B8A2C269_OtW_1, _CustomFunction_B8A2C269_WtO_2);
                float3 _Multiply_9802A92E_Out_2;
                Unity_Multiply_float(IN.ObjectSpacePosition, (_CustomFunction_B8A2C269_Dummy_0.xxx), _Multiply_9802A92E_Out_2);
                float4 _UV_70BB8A47_Out_0 = IN.uv1;
                float4 _UV_AD9298DE_Out_0 = IN.uv2;
                Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc _PositionGPUAnimation_90E03856;
                float3 _PositionGPUAnimation_90E03856_WorldSpace_1;
                float3 _PositionGPUAnimation_90E03856_ViewSpace_2;
                float4 _PositionGPUAnimation_90E03856_ClipSpace_3;
                float4 _PositionGPUAnimation_90E03856_NormalizedDevice_4;
                SG_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc(_Multiply_9802A92E_Out_2, (_UV_70BB8A47_Out_0.xy), (_UV_AD9298DE_Out_0.xy), _PositionGPUAnimation_90E03856, _PositionGPUAnimation_90E03856_WorldSpace_1, _PositionGPUAnimation_90E03856_ViewSpace_2, _PositionGPUAnimation_90E03856_ClipSpace_3, _PositionGPUAnimation_90E03856_NormalizedDevice_4);
                float3 _Transform_E35C6C28_Out_1 = TransformWorldToObject(_PositionGPUAnimation_90E03856_WorldSpace_1.xyz);
                description.VertexPosition = _Transform_E35C6C28_Out_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float4 uv1;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID;
                #endif
            };
            
            struct SurfaceDescription
            {
                float3 Color;
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _UV_111FD959_Out_0 = IN.uv1;
                float4 _CustomFunction_386BF6AB_New1_1;
                float4 _CustomFunction_386BF6AB_New2_2;
                float4 _CustomFunction_386BF6AB_New3_3;
                DebugGPUAnimationTextures_float((_UV_111FD959_Out_0.xy), _CustomFunction_386BF6AB_New1_1, _CustomFunction_386BF6AB_New2_2, _CustomFunction_386BF6AB_New3_3);
                #if UNITY_ANY_INSTANCING_ENABLED
                float _Property_2F2A2D88_Out_0 = _Value[IN.instanceID];
                #else 
                float _Property_2F2A2D88_Out_0 = 0;
                #endif //UNITY_ACCESS_INSTANCED_PROP(Props, _Value);
                float _OneMinus_F8E66F29_Out_1;
                Unity_OneMinus_float(_Property_2F2A2D88_Out_0, _OneMinus_F8E66F29_Out_1);
                float _Property_3F9A668C_Out_0 = Vector1_6CC10AE3;
                surface.Color = (_CustomFunction_386BF6AB_New3_3.xyz);

                surface.Color = _Property_2F2A2D88_Out_0; //UNITY_ACCESS_INSTANCED_PROP(Props, _Value);

                surface.Alpha = _OneMinus_F8E66F29_Out_1;
                surface.AlphaClipThreshold = _Property_3F9A668C_Out_0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_Position;
                float4 texCoord1;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float4 interp00 : TEXCOORD0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
                output.interp00.xyzw = input.texCoord1;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                output.texCoord1 = input.interp00.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                output.ObjectSpacePosition =         input.positionOS;
                output.uv1 =                         input.uv1;
                output.uv2 =                         input.uv2;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
                output.uv1 =                         input.texCoord1;
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/UnlitPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "ShadowCaster"
            Tags 
            { 
                "LightMode" = "ShadowCaster"
            }
           
            // Render State
            Blend One Zero, One Zero
            Cull Back
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_SHADOWCASTER
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            // CBUFFER_START(UnityPerMaterial)
            // float _Value;
            // CBUFFER_END
            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float, _Value)
            UNITY_INSTANCING_BUFFER_END(Props)
            float Vector1_6CC10AE3;
        
            // Graph Functions
            
            // ec0ff9673c9253f0f0a3b714ae17e4d4
            #include "Packages/com.kvrl.gpuanimation/Shaders/GPUAnimation_ShaderGraph.hlsl"
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            struct Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc
            {
            };
            
            void SG_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc(float3 Vector3_B360E246, float2 Vector2_354F2D33, float2 Vector2_14A95160, Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc IN, out float3 WorldSpace_1, out float3 ViewSpace_2, out float4 ClipSpace_3, out float4 NormalizedDevice_4)
            {
                float3 _Property_DC617EF3_Out_0 = Vector3_B360E246;
                float2 _Property_9A45716B_Out_0 = Vector2_354F2D33;
                float2 _Property_A68BECEF_Out_0 = Vector2_14A95160;
                float3 _CustomFunction_A1E2AF63_PositionWS_3;
                float3 _CustomFunction_A1E2AF63_PositionVS_4;
                float4 _CustomFunction_A1E2AF63_PositionCS_5;
                float4 _CustomFunction_A1E2AF63_PositionNDC_6;
                Position_GPUAnimation_float(_Property_DC617EF3_Out_0, _Property_9A45716B_Out_0, _Property_A68BECEF_Out_0, _CustomFunction_A1E2AF63_PositionWS_3, _CustomFunction_A1E2AF63_PositionVS_4, _CustomFunction_A1E2AF63_PositionCS_5, _CustomFunction_A1E2AF63_PositionNDC_6);
                WorldSpace_1 = _CustomFunction_A1E2AF63_PositionWS_3;
                ViewSpace_2 = _CustomFunction_A1E2AF63_PositionVS_4;
                ClipSpace_3 = _CustomFunction_A1E2AF63_PositionCS_5;
                NormalizedDevice_4 = _CustomFunction_A1E2AF63_PositionNDC_6;
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 WorldSpaceTangent;
                float3 ObjectSpaceBiTangent;
                float3 WorldSpaceBiTangent;
                float3 ObjectSpacePosition;
                float4 uv1;
                float4 uv2;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float _CustomFunction_B8A2C269_Dummy_0;
                float4x4 _CustomFunction_B8A2C269_OtW_1;
                float4x4 _CustomFunction_B8A2C269_WtO_2;
                Setup_GPUAnimation_float(_CustomFunction_B8A2C269_Dummy_0, _CustomFunction_B8A2C269_OtW_1, _CustomFunction_B8A2C269_WtO_2);
                float3 _Multiply_9802A92E_Out_2;
                Unity_Multiply_float(IN.ObjectSpacePosition, (_CustomFunction_B8A2C269_Dummy_0.xxx), _Multiply_9802A92E_Out_2);
                float4 _UV_70BB8A47_Out_0 = IN.uv1;
                float4 _UV_AD9298DE_Out_0 = IN.uv2;
                Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc _PositionGPUAnimation_90E03856;
                float3 _PositionGPUAnimation_90E03856_WorldSpace_1;
                float3 _PositionGPUAnimation_90E03856_ViewSpace_2;
                float4 _PositionGPUAnimation_90E03856_ClipSpace_3;
                float4 _PositionGPUAnimation_90E03856_NormalizedDevice_4;
                SG_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc(_Multiply_9802A92E_Out_2, (_UV_70BB8A47_Out_0.xy), (_UV_AD9298DE_Out_0.xy), _PositionGPUAnimation_90E03856, _PositionGPUAnimation_90E03856_WorldSpace_1, _PositionGPUAnimation_90E03856_ViewSpace_2, _PositionGPUAnimation_90E03856_ClipSpace_3, _PositionGPUAnimation_90E03856_NormalizedDevice_4);
                float3 _Transform_E35C6C28_Out_1 = TransformWorldToObject(_PositionGPUAnimation_90E03856_WorldSpace_1.xyz);
                description.VertexPosition = _Transform_E35C6C28_Out_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float _Property_2F2A2D88_Out_0 = UNITY_ACCESS_INSTANCED_PROP(Props, _Value);
                float _OneMinus_F8E66F29_Out_1;
                Unity_OneMinus_float(_Property_2F2A2D88_Out_0, _OneMinus_F8E66F29_Out_1);
                float _Property_3F9A668C_Out_0 = Vector1_6CC10AE3;
                surface.Alpha = _OneMinus_F8E66F29_Out_1;
                surface.AlphaClipThreshold = _Property_3F9A668C_Out_0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                output.ObjectSpacePosition =         input.positionOS;
                output.uv1 =                         input.uv1;
                output.uv2 =                         input.uv2;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "DepthOnly"
            Tags 
            { 
                "LightMode" = "DepthOnly"
            }
           
            // Render State
            Blend One Zero, One Zero
            Cull Back
            ZTest LEqual
            ZWrite On
            ColorMask 0
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_DEPTHONLY
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            // CBUFFER_START(UnityPerMaterial)
            // float _Value;
            // CBUFFER_END
            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float, _Value)
            UNITY_INSTANCING_BUFFER_END(Props)
            float Vector1_6CC10AE3;
        
            // Graph Functions
            
            // ec0ff9673c9253f0f0a3b714ae17e4d4
            #include "Packages/com.kvrl.gpuanimation/Shaders/GPUAnimation_ShaderGraph.hlsl"
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            struct Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc
            {
            };
            
            void SG_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc(float3 Vector3_B360E246, float2 Vector2_354F2D33, float2 Vector2_14A95160, Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc IN, out float3 WorldSpace_1, out float3 ViewSpace_2, out float4 ClipSpace_3, out float4 NormalizedDevice_4)
            {
                float3 _Property_DC617EF3_Out_0 = Vector3_B360E246;
                float2 _Property_9A45716B_Out_0 = Vector2_354F2D33;
                float2 _Property_A68BECEF_Out_0 = Vector2_14A95160;
                float3 _CustomFunction_A1E2AF63_PositionWS_3;
                float3 _CustomFunction_A1E2AF63_PositionVS_4;
                float4 _CustomFunction_A1E2AF63_PositionCS_5;
                float4 _CustomFunction_A1E2AF63_PositionNDC_6;
                Position_GPUAnimation_float(_Property_DC617EF3_Out_0, _Property_9A45716B_Out_0, _Property_A68BECEF_Out_0, _CustomFunction_A1E2AF63_PositionWS_3, _CustomFunction_A1E2AF63_PositionVS_4, _CustomFunction_A1E2AF63_PositionCS_5, _CustomFunction_A1E2AF63_PositionNDC_6);
                WorldSpace_1 = _CustomFunction_A1E2AF63_PositionWS_3;
                ViewSpace_2 = _CustomFunction_A1E2AF63_PositionVS_4;
                ClipSpace_3 = _CustomFunction_A1E2AF63_PositionCS_5;
                NormalizedDevice_4 = _CustomFunction_A1E2AF63_PositionNDC_6;
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 WorldSpaceTangent;
                float3 ObjectSpaceBiTangent;
                float3 WorldSpaceBiTangent;
                float3 ObjectSpacePosition;
                float4 uv1;
                float4 uv2;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float _CustomFunction_B8A2C269_Dummy_0;
                float4x4 _CustomFunction_B8A2C269_OtW_1;
                float4x4 _CustomFunction_B8A2C269_WtO_2;
                Setup_GPUAnimation_float(_CustomFunction_B8A2C269_Dummy_0, _CustomFunction_B8A2C269_OtW_1, _CustomFunction_B8A2C269_WtO_2);
                float3 _Multiply_9802A92E_Out_2;
                Unity_Multiply_float(IN.ObjectSpacePosition, (_CustomFunction_B8A2C269_Dummy_0.xxx), _Multiply_9802A92E_Out_2);
                float4 _UV_70BB8A47_Out_0 = IN.uv1;
                float4 _UV_AD9298DE_Out_0 = IN.uv2;
                Bindings_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc _PositionGPUAnimation_90E03856;
                float3 _PositionGPUAnimation_90E03856_WorldSpace_1;
                float3 _PositionGPUAnimation_90E03856_ViewSpace_2;
                float4 _PositionGPUAnimation_90E03856_ClipSpace_3;
                float4 _PositionGPUAnimation_90E03856_NormalizedDevice_4;
                SG_PositionGPUAnimation_b34183fd4868ef84dbe05a50741780fc(_Multiply_9802A92E_Out_2, (_UV_70BB8A47_Out_0.xy), (_UV_AD9298DE_Out_0.xy), _PositionGPUAnimation_90E03856, _PositionGPUAnimation_90E03856_WorldSpace_1, _PositionGPUAnimation_90E03856_ViewSpace_2, _PositionGPUAnimation_90E03856_ClipSpace_3, _PositionGPUAnimation_90E03856_NormalizedDevice_4);
                float3 _Transform_E35C6C28_Out_1 = TransformWorldToObject(_PositionGPUAnimation_90E03856_WorldSpace_1.xyz);
                description.VertexPosition = _Transform_E35C6C28_Out_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float _Property_2F2A2D88_Out_0 = UNITY_ACCESS_INSTANCED_PROP(Props, _Value);
                float _OneMinus_F8E66F29_Out_1;
                Unity_OneMinus_float(_Property_2F2A2D88_Out_0, _OneMinus_F8E66F29_Out_1);
                float _Property_3F9A668C_Out_0 = Vector1_6CC10AE3;
                surface.Alpha = _OneMinus_F8E66F29_Out_1;
                surface.AlphaClipThreshold = _Property_3F9A668C_Out_0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                output.ObjectSpacePosition =         input.positionOS;
                output.uv1 =                         input.uv1;
                output.uv2 =                         input.uv2;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
            ENDHLSL
        }
        
    }
    FallBack "Hidden/Shader Graph/FallbackError"
}
