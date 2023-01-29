// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TetraArts/Tatoon2/Built-in/Tatoon2_Built-in"
{
	Properties
	{
		_ShadowSize("ShadowSize", Range( 0 , 2)) = 0
		_ShadowBlend("ShadowBlend", Range( 0 , 1)) = 0
		_DiffuseColor("Diffuse Color", Color) = (1,0.75,0.75,0)
		[Toggle]_UseRim("UseRim", Float) = 1
		[Toggle]_UseNormalMap("UseNormalMap", Float) = 0
		_RimColor("Rim Color", Color) = (0,1,0.8758622,0)
		_MainTexture("MainTexture", 2D) = "white" {}
		[NoScaleOffset]_RimTexture("Rim Texture", 2D) = "white" {}
		[Toggle]_RimTextureViewProjection("Rim Texture View Projection", Float) = 0
		_NormalStrength("Normal Strength", Range( 0 , 1)) = 1
		_RimTextureTiling("Rim Texture Tiling", Float) = 0
		_ShadowColor("Shadow Color", Color) = (1,0,0,1)
		_RimTextureRotation("Rim Texture Rotation", Float) = 0
		[Toggle]_RimLightColor("Rim Light Color", Float) = 0
		_RimLightIntensity("Rim Light Intensity", Range( 0 , 10)) = 0
		[NoScaleOffset]_ShadowTexture("Shadow Texture", 2D) = "white" {}
		_RimSize("Rim Size", Range( -1 , 2)) = 0.4104842
		_RimBlend("Rim Blend", Range( 0 , 10)) = 0
		[Toggle]_ShadowTextureViewProjection("Shadow Texture View Projection", Float) = 0
		[Toggle]_UseSpecular("UseSpecular", Float) = 1
		_ShadowTextureTiling("Shadow Texture Tiling", Float) = 0
		[Toggle]_UseGradient("Use Gradient", Float) = 0
		[NoScaleOffset]_SpecularMap("Specular Map", 2D) = "gray" {}
		_ShadowTextureRotation("Shadow Texture Rotation", Float) = 0
		[Toggle]_SpecularTextureViewProjection("Specular Texture View Projection", Float) = 0
		_ColorB("Color B", Color) = (0,0.1264467,1,0)
		_ColorA("Color A", Color) = (1,0,0,0)
		[Toggle]_UseShadow("UseShadow", Float) = 0
		_SpecularTextureTiling("Specular Texture Tiling", Float) = 0
		_SpecularTextureRotation("Specular Texture Rotation", Float) = 0
		_GradientSize("Gradient Size", Range( 0 , 10)) = 0
		_SpecularColor("Specular Color", Color) = (1,0.9575656,0.75,0)
		[Toggle]_SpecLightColor("Spec Light Color", Float) = 0
		_GradientPosition("Gradient Position", Float) = 0
		_SpecularLightIntensity("Specular Light Intensity", Range( 0 , 10)) = 1
		_GradientRotation("Gradient Rotation", Float) = 0
		_SpecularSize("Specular Size", Range( 0 , 1)) = 0.005
		_SpecularBlend("Specular Blend", Range( 0 , 1)) = 0
		_NormalMap("NormalMap", 2D) = "bump" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		[Toggle]_Level2("Level2", Float) = 0
		[Toggle]_Level3("Level3", Float) = 0
		[Toggle]_Animate("Animate", Float) = 0
		[Toggle]_UseShadowTexture("UseShadowTexture", Float) = 0
		_XDirectionSpeed("XDirectionSpeed", Float) = 0
		_YDirectionSpeed("YDirectionSpeed", Float) = 0
		[Toggle]_ChangeAxis("ChangeAxis", Float) = 0
		_EmissiveMap("EmissiveMap", 2D) = "white" {}
		[Toggle]_UseEmissive("UseEmissive", Float) = 0
		[HDR]_EmissiveColor("EmissiveColor", Color) = (2.996078,0.0611825,0,0)
		_TextureRamp("_TextureRamp", 2D) = "white" {}
		[Toggle]_UseRamp("UseRamp", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _UseEmissive;
		uniform float4 _EmissiveColor;
		uniform sampler2D _EmissiveMap;
		uniform float4 _EmissiveMap_ST;
		uniform float _UseNormalMap;
		uniform float _UseShadow;
		uniform float _UseShadowTexture;
		uniform float4 _ShadowColor;
		uniform sampler2D _ShadowTexture;
		uniform float _ShadowTextureViewProjection;
		uniform float _ShadowTextureTiling;
		uniform float _Animate;
		uniform float _XDirectionSpeed;
		uniform float _YDirectionSpeed;
		uniform float _ShadowTextureRotation;
		uniform float _Level2;
		uniform float _Level3;
		uniform float _UseGradient;
		uniform float4 _DiffuseColor;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform float _GradientPosition;
		uniform float _GradientSize;
		uniform float _ChangeAxis;
		uniform float _GradientRotation;
		uniform sampler2D _MainTexture;
		uniform float4 _MainTexture_ST;
		uniform float _ShadowSize;
		uniform float _ShadowBlend;
		uniform float _UseRamp;
		uniform sampler2D _TextureRamp;
		uniform float _UseRim;
		uniform float _RimSize;
		uniform float _RimBlend;
		uniform float _RimLightColor;
		uniform float4 _RimColor;
		uniform float _RimLightIntensity;
		uniform sampler2D _RimTexture;
		uniform float _RimTextureViewProjection;
		uniform float _RimTextureTiling;
		uniform float _RimTextureRotation;
		uniform float _UseSpecular;
		uniform sampler2D _SpecularMap;
		uniform float _SpecularTextureViewProjection;
		uniform float _SpecularTextureTiling;
		uniform float _SpecularTextureRotation;
		uniform float _SpecLightColor;
		uniform float4 _SpecularColor;
		uniform float _SpecularLightIntensity;
		uniform float _SpecularSize;
		uniform float _SpecularBlend;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _NormalStrength;
		uniform float _Smoothness;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float4 color218 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_output_408_0 = ( float4( ase_lightColor.rgb , 0.0 ) * _ShadowColor );
			float2 temp_cast_4 = (_ShadowTextureTiling).xx;
			float2 uv_TexCoord209 = i.uv_texcoord * temp_cast_4;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 temp_output_210_0 = ( ( _ShadowTextureTiling * 1 ) * mul( UNITY_MATRIX_VP, float4( ase_worldViewDir , 0.0 ) ).xyz );
			float2 appendResult423 = (float2(_XDirectionSpeed , _YDirectionSpeed));
			float2 panner403 = ( 1.0 * _Time.y * appendResult423 + temp_output_210_0.xy);
			float cos356 = cos( radians( _ShadowTextureRotation ) );
			float sin356 = sin( radians( _ShadowTextureRotation ) );
			float2 rotator356 = mul( (( _ShadowTextureViewProjection )?( (( _Animate )?( float3( panner403 ,  0.0 ) ):( temp_output_210_0 )) ):( float3( uv_TexCoord209 ,  0.0 ) )).xy - float2( 0,0 ) , float2x2( cos356 , -sin356 , sin356 , cos356 )) + float2( 0,0 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float dotResult3 = dot( ase_worldlightDir , ase_worldNormal );
			float N398 = dotResult3;
			float smoothstepResult380 = smoothstep( -0.5 , 0.05 , N398);
			float cos214 = cos( radians( ( _ShadowTextureRotation + 90.0 ) ) );
			float sin214 = sin( radians( ( _ShadowTextureRotation + 90.0 ) ) );
			float2 rotator214 = mul( (( _ShadowTextureViewProjection )?( (( _Animate )?( float3( panner403 ,  0.0 ) ):( temp_output_210_0 )) ):( float3( uv_TexCoord209 ,  0.0 ) )).xy - float2( 0,0 ) , float2x2( cos214 , -sin214 , sin214 , cos214 )) + float2( 0,0 );
			float smoothstepResult399 = smoothstep( -0.5 , 0.5 , N398);
			float cos360 = cos( radians( ( _ShadowTextureRotation + 45.0 ) ) );
			float sin360 = sin( radians( ( _ShadowTextureRotation + 45.0 ) ) );
			float2 rotator360 = mul( (( _ShadowTextureViewProjection )?( (( _Animate )?( float3( panner403 ,  0.0 ) ):( temp_output_210_0 )) ):( float3( uv_TexCoord209 ,  0.0 ) )).xy - float2( 0,0 ) , float2x2( cos360 , -sin360 , sin360 , cos360 )) + float2( 0,0 );
			float smoothstepResult386 = smoothstep( -0.5 , 1.0 , N398);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float2 appendResult290 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.y));
			float2 appendResult424 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float cos292 = cos( radians( _GradientRotation ) );
			float sin292 = sin( radians( _GradientRotation ) );
			float2 rotator292 = mul( (( _ChangeAxis )?( appendResult424 ):( appendResult290 )) - float2( 0,0 ) , float2x2( cos292 , -sin292 , sin292 , cos292 )) + float2( 0,0 );
			float smoothstepResult297 = smoothstep( _GradientPosition , ( _GradientPosition + _GradientSize ) , rotator292.x);
			float4 lerpResult301 = lerp( _ColorA , _ColorB , smoothstepResult297);
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float4 tex2DNode304 = tex2D( _MainTexture, uv_MainTexture );
			float4 MainColor307 = ( (( _UseGradient )?( lerpResult301 ):( _DiffuseColor )) * tex2DNode304 );
			float4 Shadow81 = ( (( _UseShadow )?( (( _UseShadowTexture )?( ( temp_output_408_0 * ( 1.0 - ( ( ( 1.0 - tex2D( _ShadowTexture, rotator356 ) ) * ( 1.0 - smoothstepResult380 ) ) + (( _Level2 )?( ( ( 1.0 - tex2D( _ShadowTexture, rotator214 ) ) * ( 1.0 - smoothstepResult399 ) ) ):( float4( 0,0,0,0 ) )) + (( _Level3 )?( ( ( 1.0 - tex2D( _ShadowTexture, rotator360 ) ) * ( 1.0 - smoothstepResult386 ) ) ):( float4( 0,0,0,0 ) )) ) ) ) ):( temp_output_408_0 )) ):( ( color218 * float4( ase_lightColor.rgb , 0.0 ) ) )) * MainColor307 );
			float smoothstepResult10 = smoothstep( _ShadowSize , ( _ShadowSize + _ShadowBlend ) , dotResult3);
			float3 temp_output_9_0 = ( ase_lightColor.rgb * pow( ase_lightAtten , 0.01 ) );
			float3 break63 = temp_output_9_0;
			float temp_output_61_0 = max( max( break63.x , break63.y ) , break63.z );
			float temp_output_73_0 = ( smoothstepResult10 * temp_output_61_0 );
			float3 temp_cast_23 = (( 1.0 - temp_output_73_0 )).xxx;
			float3 temp_output_64_0 = ( smoothstepResult10 * temp_output_9_0 );
			#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch76 = temp_output_64_0;
			#else
				float3 staticSwitch76 = temp_cast_23;
			#endif
			float3 LightingInfos77 = staticSwitch76;
			float4 lerpResult46 = lerp( float4( 0,0,0,0 ) , Shadow81 , float4( LightingInfos77 , 0.0 ));
			#ifdef UNITY_PASS_FORWARDADD
				float3 staticSwitch58 = temp_output_64_0;
			#else
				float3 staticSwitch58 = ( temp_output_64_0 * temp_output_61_0 );
			#endif
			float2 temp_cast_26 = ((N398*0.5 + 0.5)).xx;
			float4 ShadowRamp443 = ( tex2D( _TextureRamp, temp_cast_26 ) * MainColor307 );
			float4 Lighting78 = (( _UseRamp )?( ShadowRamp443 ):( float4( staticSwitch58 , 0.0 ) ));
			float4 lerpResult67 = lerp( float4( 0,0,0,0 ) , MainColor307 , Lighting78);
			float NdotL122 = temp_output_73_0;
			float dotResult116 = dot( ase_worldNormal , ase_worldViewDir );
			float2 temp_cast_28 = (_RimTextureTiling).xx;
			float2 uv_TexCoord99 = i.uv_texcoord * temp_cast_28;
			float cos112 = cos( radians( _RimTextureRotation ) );
			float sin112 = sin( radians( _RimTextureRotation ) );
			float2 rotator112 = mul( (( _RimTextureViewProjection )?( ( ( _RimTextureTiling * 1 ) * mul( float4( ase_worldViewDir , 0.0 ), UNITY_MATRIX_VP ).xyz ) ):( float3( uv_TexCoord99 ,  0.0 ) )).xy - float2( 0,0 ) , float2x2( cos112 , -sin112 , sin112 , cos112 )) + float2( 0,0 );
			float4 Rim121 = (( _UseRim )?( ( saturate( ( NdotL122 * pow( ( 1.0 - saturate( ( dotResult116 + ( 1.0 - _RimSize ) ) ) ) , _RimBlend ) ) ) * ( (( _RimLightColor )?( float4( ( _RimLightIntensity * ase_lightColor.rgb ) , 0.0 ) ):( _RimColor )) * tex2D( _RimTexture, rotator112 ) ) ) ):( float4( 0,0,0,0 ) ));
			float2 temp_cast_33 = (_SpecularTextureTiling).xx;
			float2 uv_TexCoord164 = i.uv_texcoord * temp_cast_33;
			float cos199 = cos( radians( _SpecularTextureRotation ) );
			float sin199 = sin( radians( _SpecularTextureRotation ) );
			float2 rotator199 = mul( (( _SpecularTextureViewProjection )?( ( ( _SpecularTextureTiling * 1 ) * mul( float4( ase_worldViewDir , 0.0 ), UNITY_MATRIX_VP ).xyz ) ):( float3( uv_TexCoord164 ,  0.0 ) )).xy - float2( 0,0 ) , float2x2( cos199 , -sin199 , sin199 , cos199 )) + float2( 0,0 );
			float temp_output_168_0 = ( 1.0 - _SpecularSize );
			float3 normalizeResult167 = normalize( ase_worldlightDir );
			float3 normalizeResult200 = normalize( ase_worldViewDir );
			float3 normalizeResult165 = normalize( ( normalizeResult167 + normalizeResult200 ) );
			float3 normalizeResult190 = normalize( ase_worldNormal );
			float dotResult179 = dot( normalizeResult165 , normalizeResult190 );
			float smoothstepResult194 = smoothstep( temp_output_168_0 , ( temp_output_168_0 + _SpecularBlend ) , dotResult179);
			float4 Specular193 = (( _UseSpecular )?( ( ( ( ( 1.0 - tex2D( _SpecularMap, rotator199 ) ) * (( _SpecLightColor )?( ( ase_lightColor * _SpecularLightIntensity ) ):( _SpecularColor )) ) * smoothstepResult194 ) * NdotL122 ) ):( float4( 0,0,0,0 ) ));
			float4 temp_output_60_0 = ( lerpResult46 + lerpResult67 + Rim121 + Specular193 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 NormalTexture339 = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalStrength );
			float3 indirectNormal334 = WorldNormalVector( i , NormalTexture339 );
			Unity_GlossyEnvironmentData g334 = UnityGlossyEnvironmentSetup( _Smoothness, data.worldViewDir, indirectNormal334, float3(0,0,0));
			float3 indirectSpecular334 = UnityGI_IndirectSpecular( data, 10.0, indirectNormal334, g334 );
			UnityGI gi337 = gi;
			float3 diffNorm337 = WorldNormalVector( i , NormalTexture339 );
			gi337 = UnityGI_Base( data, 1, diffNorm337 );
			float3 indirectDiffuse337 = gi337.indirect.diffuse + diffNorm337 * 0.0001;
			float3 Smoothness345 = ( indirectSpecular334 + indirectDiffuse337 );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV332 = dot( mul(ase_tangentToWorldFast,NormalTexture339), ase_worldViewDir );
			float fresnelNode332 = ( -0.2 + 0.5 * pow( max( 1.0 - fresnelNdotV332 , 0.0001 ), 1.0 ) );
			float4 Fresnel347 = ( fresnelNode332 * MainColor307 );
			float4 lerpResult333 = lerp( temp_output_60_0 , float4( Smoothness345 , 0.0 ) , Fresnel347);
			float4 Result329 = (( _UseNormalMap )?( lerpResult333 ):( temp_output_60_0 ));
			c.rgb = Result329.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_EmissiveMap = i.uv_texcoord * _EmissiveMap_ST.xy + _EmissiveMap_ST.zw;
			float4 Emissive434 = (( _UseEmissive )?( ( _EmissiveColor * (tex2D( _EmissiveMap, uv_EmissiveMap )).rgba ) ):( float4( 0,0,0,0 ) ));
			o.Emission = Emissive434.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "TatoonEditor"
}
/*ASEBEGIN
Version=18935
2145;33;1219;898;221.6817;-2963.289;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;203;-3950.144,-1362.448;Inherit;False;4920.745;925.1801;Shadow;58;376;367;401;400;381;380;377;81;18;220;86;219;407;408;392;406;216;384;382;366;402;385;386;217;355;359;399;369;356;387;215;214;360;357;212;361;213;363;362;403;209;364;211;365;210;207;208;205;204;206;218;410;415;416;418;421;422;423;Shadow tex&color;0,0,0,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;205;-3673.052,-717.382;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;206;-3672.033,-1047.808;Inherit;False;Property;_ShadowTextureTiling;Shadow Texture Tiling;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewProjectionMatrixNode;204;-3699.713,-828.3357;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;422;-3506.05,-543.3158;Inherit;False;Property;_YDirectionSpeed;YDirectionSpeed;45;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;421;-3507.307,-622.8287;Inherit;False;Property;_XDirectionSpeed;XDirectionSpeed;44;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;208;-3467.541,-764.744;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleNode;207;-3448.425,-939.5887;Inherit;False;1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;286;-2245.3,-2419.684;Inherit;False;3225.823;877.6078;Albedo And Gradient;23;425;424;290;289;288;305;307;306;304;303;300;302;301;298;299;297;295;296;293;292;294;291;287;MainColor & Gradient;1,0,0,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;423;-3281.125,-618.2382;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;287;-2065.708,-2222.186;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-3298.697,-888.0674;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;57;-1780.723,-340.3744;Inherit;False;2700.444;915.5321;Comment;26;78;58;71;77;76;75;64;122;73;61;10;62;13;11;12;63;9;426;7;8;398;3;1;2;444;445;Lighting;0.9427508,1,0,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;290;-1796.345,-2252.618;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-1591.551,-137.776;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;2;-1625.498,-290.3744;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;365;-2886.193,-541.9921;Inherit;False;Constant;_Float4;Float 4;58;0;Create;True;0;0;0;False;0;False;45;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;211;-2952.789,-723.2004;Inherit;False;Property;_ShadowTextureRotation;Shadow Texture Rotation;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;364;-2889.193,-617.9921;Inherit;False;Constant;_Float3;Float 3;58;0;Create;True;0;0;0;False;0;False;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;403;-3137.31,-812.5699;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;288;-1880.119,-1755.767;Inherit;False;Property;_GradientRotation;Gradient Rotation;35;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;424;-1793.525,-2141.873;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;291;-1765.243,-1946.091;Inherit;False;Constant;_Vector0;Vector 0;45;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RadiansOpNode;289;-1664.198,-1753.182;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;363;-2702.193,-568.9921;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;425;-1648.874,-2190.086;Inherit;False;Property;_ChangeAxis;ChangeAxis;46;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;416;-2961.819,-893.2912;Inherit;False;Property;_Animate;Animate;42;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;209;-3420.447,-1085.819;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;3;-1315.87,-247.3855;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;362;-2663.193,-731.9921;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;213;-2778.431,-995.1993;Inherit;False;Property;_ShadowTextureViewProjection;Shadow Texture View Projection;18;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RadiansOpNode;212;-2529.075,-805.3345;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;398;-1101.756,-328.2067;Inherit;False;N;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;361;-2553.521,-623.1453;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;8;-1655.701,344.4396;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;292;-1471.273,-1944.344;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;293;-1373.498,-1704.568;Inherit;False;Property;_GradientSize;Gradient Size;30;0;Create;True;0;0;0;False;0;False;0;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-1214.584,-1787.595;Inherit;False;Property;_GradientPosition;Gradient Position;33;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;296;-1221.495,-1942.309;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;295;-964.7944,-1779.802;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;214;-2423.439,-967.4888;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;163;-2371.307,1982.77;Inherit;False;3301.643;968.2485;Specular;38;201;200;199;198;197;196;195;194;193;192;191;190;189;188;187;186;185;184;183;182;181;180;179;178;177;176;175;174;173;172;171;170;169;168;167;166;165;164;Specular;1,0.8174672,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;387;-1733.526,-650.6461;Inherit;False;398;N;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;360;-2407.885,-724.4999;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-1742.69,-907.7612;Inherit;False;398;N;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;426;-1377.691,344.0146;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;357;-2529.671,-1138.625;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;215;-3209.746,-1280.507;Inherit;True;Property;_ShadowTexture;Shadow Texture;15;1;[NoScaleOffset];Create;True;0;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LightColorNode;7;-1391.256,190.8622;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1124.857,208.5604;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;377;-1825.591,-1173.068;Inherit;False;398;N;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewProjectionMatrixNode;175;-2323.65,2558.09;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SmoothstepOpNode;399;-1499.382,-901.3561;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;359;-2208.617,-749.0729;Inherit;True;Property;_TextureSample3;Texture Sample 3;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;217;-2206.277,-998.7722;Inherit;True;Property;_tex1;tex1;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;87;-1741.844,695.1132;Inherit;False;2649.39;1146.548;;35;121;120;119;118;117;116;115;114;113;112;111;110;109;108;107;106;105;104;103;102;101;100;99;98;97;96;95;94;93;92;91;90;89;88;125;Rim;0,1,0.9419038,1;0;0
Node;AmplifyShaderEditor.SmoothstepOpNode;386;-1505.278,-659.1597;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;297;-830.7225,-1957.202;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;356;-2374.434,-1223.98;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-2327.173,2177.696;Inherit;False;Property;_SpecularTextureTiling;Specular Texture Tiling;28;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;195;-2321.308,2386.043;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;299;-1100.242,-2369.684;Inherit;False;Property;_ColorA;Color A;26;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;298;-1096.852,-2193.969;Inherit;False;Property;_ColorB;Color B;25;0;Create;True;0;0;0;False;0;False;0,0.1264467,1,0;0,0.1264467,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleNode;166;-2053.018,2312.79;Inherit;False;1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;402;-1689.181,-745.3542;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;401;-1612.431,-988.105;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;355;-2166.906,-1276.274;Inherit;True;Property;_TextureSample4;Texture Sample 4;14;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1443.725,94.60631;Inherit;False;Property;_ShadowBlend;ShadowBlend;1;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;106;-1603.03,1008.119;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;11;-1434.299,17.00064;Inherit;False;Property;_ShadowSize;ShadowSize;0;0;Create;True;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;366;-1304.121,-891.2411;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;380;-1539.243,-1166.982;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-0.5;False;2;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;301;-555.6292,-2210.429;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;63;-967.7352,254.7011;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WorldNormalVector;107;-1636.131,853.5192;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;385;-1311.856,-671.4261;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;302;-264.2921,-2001.439;Inherit;True;Property;_MainTexture;MainTexture;6;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-2065.325,2414.316;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;300;-227.6259,-2326.052;Inherit;False;Property;_DiffuseColor;Diffuse Color;2;0;Create;True;0;0;0;False;0;False;1,0.75,0.75,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;114;-1570.992,1201.408;Float;False;Property;_RimSize;Rim Size;16;0;Create;True;0;0;0;False;0;False;0.4104842;0;-1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;116;-1332.132,933.5191;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;62;-815.5723,252.8456;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-1696.809,2342.806;Inherit;False;Property;_SpecularTextureRotation;Specular Texture Rotation;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-1533.013,1420.147;Inherit;False;Property;_RimTextureTiling;Rim Texture Tiling;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;120;-1570.091,1549.109;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;367;-1147.673,-982.1275;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewProjectionMatrixNode;110;-1591.105,1715.575;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;196;-1584.304,2574.423;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;201;-1605.58,2424.788;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-1908.283,2312.79;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;381;-1344.021,-1161.348;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;303;75.61691,-2149.442;Inherit;False;Property;_UseGradient;Use Gradient;21;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;304;-27.31708,-2005.446;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;400;-1649.831,-1266.853;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-1127.733,66.27679;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;384;-1142.509,-740.8118;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;164;-1917.18,2180.187;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;436;1664,-352;Inherit;False;1319.844;576.9281;Comment;7;443;442;441;440;439;438;437;ShadowRamp;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;125;-1277.076,1093.469;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;382;-1148.024,-1271.087;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;167;-1349.962,2424.779;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;61;-687.5319,288.1031;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;200;-1351.487,2578.892;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;198;-1620.781,2174.486;Inherit;False;Property;_SpecularTextureViewProjection;Specular Texture View Projection;24;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleNode;94;-1261.945,1550.375;Inherit;False;1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;415;-837.721,-818.0474;Inherit;False;Property;_Level3;Level3;41;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;410;-845.5831,-956.655;Inherit;False;Property;_Level2;Level2;40;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;306;559.4188,-2087.719;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RadiansOpNode;178;-1398.48,2315.088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;437;1728,0;Inherit;True;398;N;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-1138.952,937.8831;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;10;-984.9102,-245.3391;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-1274.076,1698.87;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-499.6097,-257.3169;Inherit;True;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;406;-435.1505,-1301.912;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightColorNode;172;-804.2791,2299.389;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;376;-481.5811,-923.3464;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0.2,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;187;-804.1781,2415.653;Inherit;False;Property;_SpecularLightIntensity;Specular Light Intensity;34;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;216;-534.7211,-1120.395;Inherit;False;Property;_ShadowColor;Shadow Color;11;0;Create;True;0;0;0;False;0;False;1,0,0,1;0.5377358,0.5377358,0.5377358,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-1114.665,1582.779;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-1249.766,2751.248;Inherit;False;Property;_SpecularSize;Specular Size;36;0;Create;True;0;0;0;False;0;False;0.005;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;95;-978.9516,937.8831;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-1115.351,2424.866;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;182;-1169.572,2594.852;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;438;1968,32;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;307;789.4708,-2089.843;Inherit;True;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;99;-1219.427,1404.401;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;118;-913.0696,1607.244;Inherit;False;Property;_RimTextureRotation;Rim Texture Rotation;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;439;1856,-304;Inherit;True;Property;_TextureRamp;_TextureRamp;50;0;Create;True;0;0;0;False;0;False;92af09dc061f8d3478a3c560ba7711bf;92af09dc061f8d3478a3c560ba7711bf;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RotatorNode;199;-1221.781,2075.998;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;98;-802.9516,889.8841;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-1157.456,2848.568;Inherit;False;Property;_SpecularBlend;Specular Blend;37;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;168;-953.4441,2760.056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-234.0527,-17.56874;Inherit;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;392;-303.1357,-847.5854;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;92;-487.3936,1276.91;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;441;2128,-304;Inherit;True;Property;_TextureSample5;Texture Sample 2;70;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;190;-961.639,2594.248;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-642.4129,1197.02;Inherit;False;Property;_RimLightIntensity;Rim Light Intensity;14;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;176;-1032.85,2224.86;Inherit;False;Property;_SpecularColor;Specular Color;31;0;Create;True;0;0;0;False;0;False;1,0.9575656,0.75,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;104;-706.6548,1603.055;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;349;-823.4875,3163.01;Inherit;False;1845.817;637.3112;Comment;16;347;335;345;338;419;420;337;334;332;340;341;342;339;317;320;311;NormalMap;0,0.2736156,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;408;-283.1653,-1106.965;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;188;-949.8331,2036.772;Inherit;True;Property;_SpecularMap;Specular Map;22;1;[NoScaleOffset];Create;True;0;0;0;False;1;;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;192;-563.4004,2282.176;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;440;2304,0;Inherit;False;307;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;109;-914.9516,1065.881;Float;False;Property;_RimBlend;Rim Blend;17;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;165;-959.0391,2426.768;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;119;-913.2736,1450.04;Inherit;False;Property;_RimTextureViewProjection;Rim Texture View Projection;8;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;320;-789.7971,3481.695;Inherit;False;Property;_NormalStrength;Normal Strength;9;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;112;-576.752,1459.025;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;219;-74.79323,-872.6683;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;181;-613.6171,2042.698;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-743.7742,-11.45497;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;89;-610.9526,937.8831;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;311;-758.8506,3233.479;Inherit;True;Property;_NormalMap;NormalMap;38;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;117;-848.1207,742.1783;Inherit;False;122;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;102;-876.5176,1264.633;Inherit;True;Property;_RimTexture;Rim Texture;7;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ToggleSwitchNode;184;-437.384,2185.374;Inherit;False;Property;_SpecLightColor;Spec Light Color;32;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-218.8182,1269.946;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;218;-117.6158,-1307.601;Inherit;False;Constant;_ShadowColor1;Shadow Color1;5;0;Create;True;0;0;0;False;1;Header(SHADOWS);False;1,1,1,1;0.5377358,0.5377358,0.5377358,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;197;-746.6322,2759.611;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;442;2560,-272;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;179;-772.1111,2493.761;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;100;-369.7779,1085.063;Float;False;Property;_RimColor;Rim Color;5;0;Create;True;0;0;0;False;0;False;0,1,0.8758622,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;443;2768,-240;Inherit;False;ShadowRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-385.3865,228.4938;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;103;-101.9271,1102.01;Inherit;False;Property;_RimLightColor;Rim Light Color;13;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;317;-509.0825,3232.097;Inherit;True;Property;_TextureSample1;Texture Sample 1;42;0;Create;True;0;0;0;False;0;False;102;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;96;-290.154,1419.348;Inherit;True;Property;_RimTex;RimTex;25;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-229.4871,2034.053;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;418;115.7107,-898.3214;Inherit;False;Property;_UseShadowTexture;UseShadowTexture;43;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;194;-581.4214,2497.452;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-353.5186,862.3012;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;407;125.7807,-1048.116;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;75;-226.8278,-252.9213;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;220;368.9525,-937.7003;Inherit;False;Property;_UseShadow;UseShadow;27;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;445;71.47958,462.4735;Inherit;False;443;ShadowRamp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;339;-186.3533,3230.426;Inherit;False;NormalTexture;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;90;-33.58532,864.1972;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;99.63989,1194.599;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;-78.17125,2161.949;Inherit;False;122;NdotL;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;58;-12.31776,223.3575;Inherit;True;Property;_Keyword0;Keyword 0;4;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDADD;Toggle;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;386.6367,-812.7995;Inherit;False;307;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;186;-35.54623,2032.769;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;341;83.92072,3225.693;Inherit;False;339;NormalTexture;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;300.043,993.4559;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;444;322.038,222.8616;Inherit;False;Property;_UseRamp;UseRamp;51;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;173;223.5967,2029;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;646.405,-881.5851;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;335;-324.3876,3548.869;Inherit;False;Property;_Smoothness;Smoothness;39;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;342;-143.5141,3465.326;Inherit;False;339;NormalTexture;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;-140.6005,3672.876;Inherit;False;339;NormalTexture;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;76;-6.341226,-236.1644;Inherit;True;Property;_Keyword0;Keyword 0;4;0;Create;True;0;0;0;False;0;False;0;0;0;False;UNITY_PASS_FORWARDADD;Toggle;2;Key0;Key1;Fetch;False;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;85;1207.226,942.7137;Inherit;False;1633.229;1059.656;Comment;14;329;321;333;60;346;348;67;202;123;46;84;79;80;83;Mix;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;420;379.8257,3457.836;Inherit;False;307;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;427;1284.413,309.8059;Inherit;False;1614.629;488.5083;Comment;7;434;433;432;431;430;429;428;Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;337;99.34601,3679.569;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;784.1451,-882.8195;Inherit;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;332;296.7126,3233.311;Inherit;True;Standard;TangentNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-0.2;False;2;FLOAT;0.5;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;111;503.3441,968.751;Inherit;False;Property;_UseRim;UseRim;3;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;347.2431,-229.7852;Inherit;True;LightingInfos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;189;462.2038,2031.221;Inherit;False;Property;_UseSpecular;UseSpecular;19;0;Create;True;0;0;0;False;0;False;1;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;578.7574,223.445;Inherit;True;Lighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectSpecularLight;334;88.0827,3529.605;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;10;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;1276.86,1165.021;Inherit;False;77;LightingInfos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;1298.211,1300.599;Inherit;False;307;MainColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;1307.151,1397.099;Inherit;False;78;Lighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;419;640.2721,3304.266;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;193;677.9958,2039.967;Inherit;True;Specular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;707.7164,972.6079;Inherit;True;Rim;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;428;1334.413,566.3327;Inherit;True;Property;_EmissiveMap;EmissiveMap;47;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;338;417.137,3577.103;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;1272.246,1059.207;Inherit;False;81;Shadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;67;1525.704,1278.066;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;46;1509.656,1046.566;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;347;795.2601,3294.684;Inherit;False;Fresnel;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;1543.34,1500.14;Inherit;True;121;Rim;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;202;1580.114,1723.386;Inherit;True;193;Specular;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;429;1609.664,565.6218;Inherit;True;Property;_TextureSample2;Texture Sample 2;61;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;666.5323,3484.706;Inherit;False;Smoothness;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;1851.667,1515.116;Inherit;False;345;Smoothness;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;430;1916.169,359.8058;Inherit;False;Property;_EmissiveColor;EmissiveColor;49;1;[HDR];Create;True;0;0;0;False;0;False;2.996078,0.0611825,0,0;2.996078,0.0611825,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;60;1823.246,1277.333;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;348;1872.897,1613.083;Inherit;False;347;Fresnel;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;431;1918.18,567.215;Inherit;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;333;2098.124,1420.634;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;432;2138.92,544.3146;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;433;2415.198,515.2781;Inherit;False;Property;_UseEmissive;UseEmissive;48;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;321;2394.29,1269.494;Inherit;False;Property;_UseNormalMap;UseNormalMap;4;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;329;2624.851,1271.334;Inherit;False;Result;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;350;3420.24,1217.589;Inherit;False;515.8643;527.5486;Comment;3;0;331;435;Master;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;434;2675.041,517.7318;Inherit;False;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;435;3474.832,1363.906;Inherit;False;434;Emissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;331;3473.593,1531.637;Inherit;False;329;Result;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;305;374.1938,-1911.087;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3688.077,1291.041;Float;False;True;-1;2;TatoonEditor;0;0;CustomLighting;TetraArts/Tatoon2/Built-in/Tatoon2_Built-in;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;0;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;208;0;204;0
WireConnection;208;1;205;0
WireConnection;207;0;206;0
WireConnection;423;0;421;0
WireConnection;423;1;422;0
WireConnection;210;0;207;0
WireConnection;210;1;208;0
WireConnection;290;0;287;1
WireConnection;290;1;287;2
WireConnection;403;0;210;0
WireConnection;403;2;423;0
WireConnection;424;0;287;2
WireConnection;424;1;287;3
WireConnection;289;0;288;0
WireConnection;363;0;211;0
WireConnection;363;1;365;0
WireConnection;425;0;290;0
WireConnection;425;1;424;0
WireConnection;416;0;210;0
WireConnection;416;1;403;0
WireConnection;209;0;206;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;362;0;211;0
WireConnection;362;1;364;0
WireConnection;213;0;209;0
WireConnection;213;1;416;0
WireConnection;212;0;362;0
WireConnection;398;0;3;0
WireConnection;361;0;363;0
WireConnection;292;0;425;0
WireConnection;292;1;291;0
WireConnection;292;2;289;0
WireConnection;296;0;292;0
WireConnection;295;0;294;0
WireConnection;295;1;293;0
WireConnection;214;0;213;0
WireConnection;214;2;212;0
WireConnection;360;0;213;0
WireConnection;360;2;361;0
WireConnection;426;0;8;0
WireConnection;357;0;211;0
WireConnection;9;0;7;1
WireConnection;9;1;426;0
WireConnection;399;0;369;0
WireConnection;359;0;215;0
WireConnection;359;1;360;0
WireConnection;217;0;215;0
WireConnection;217;1;214;0
WireConnection;386;0;387;0
WireConnection;297;0;296;0
WireConnection;297;1;294;0
WireConnection;297;2;295;0
WireConnection;356;0;213;0
WireConnection;356;2;357;0
WireConnection;166;0;177;0
WireConnection;402;0;359;0
WireConnection;401;0;217;0
WireConnection;355;0;215;0
WireConnection;355;1;356;0
WireConnection;366;0;399;0
WireConnection;380;0;377;0
WireConnection;301;0;299;0
WireConnection;301;1;298;0
WireConnection;301;2;297;0
WireConnection;63;0;9;0
WireConnection;385;0;386;0
WireConnection;185;0;195;0
WireConnection;185;1;175;0
WireConnection;116;0;107;0
WireConnection;116;1;106;0
WireConnection;62;0;63;0
WireConnection;62;1;63;1
WireConnection;367;0;401;0
WireConnection;367;1;366;0
WireConnection;180;0;166;0
WireConnection;180;1;185;0
WireConnection;381;0;380;0
WireConnection;303;0;300;0
WireConnection;303;1;301;0
WireConnection;304;0;302;0
WireConnection;400;0;355;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;384;0;402;0
WireConnection;384;1;385;0
WireConnection;164;0;177;0
WireConnection;125;0;114;0
WireConnection;382;0;400;0
WireConnection;382;1;381;0
WireConnection;167;0;201;0
WireConnection;61;0;62;0
WireConnection;61;1;63;2
WireConnection;200;0;196;0
WireConnection;198;0;164;0
WireConnection;198;1;180;0
WireConnection;94;0;88;0
WireConnection;415;1;384;0
WireConnection;410;1;367;0
WireConnection;306;0;303;0
WireConnection;306;1;304;0
WireConnection;178;0;169;0
WireConnection;93;0;116;0
WireConnection;93;1;125;0
WireConnection;10;0;3;0
WireConnection;10;1;11;0
WireConnection;10;2;13;0
WireConnection;101;0;120;0
WireConnection;101;1;110;0
WireConnection;73;0;10;0
WireConnection;73;1;61;0
WireConnection;376;0;382;0
WireConnection;376;1;410;0
WireConnection;376;2;415;0
WireConnection;108;0;94;0
WireConnection;108;1;101;0
WireConnection;95;0;93;0
WireConnection;170;0;167;0
WireConnection;170;1;200;0
WireConnection;438;0;437;0
WireConnection;307;0;306;0
WireConnection;99;0;88;0
WireConnection;199;0;198;0
WireConnection;199;2;178;0
WireConnection;98;0;95;0
WireConnection;168;0;171;0
WireConnection;122;0;73;0
WireConnection;392;0;376;0
WireConnection;441;0;439;0
WireConnection;441;1;438;0
WireConnection;190;0;182;0
WireConnection;104;0;118;0
WireConnection;408;0;406;1
WireConnection;408;1;216;0
WireConnection;188;1;199;0
WireConnection;192;0;172;0
WireConnection;192;1;187;0
WireConnection;165;0;170;0
WireConnection;119;0;99;0
WireConnection;119;1;108;0
WireConnection;112;0;119;0
WireConnection;112;2;104;0
WireConnection;219;0;408;0
WireConnection;219;1;392;0
WireConnection;181;0;188;0
WireConnection;64;0;10;0
WireConnection;64;1;9;0
WireConnection;89;0;98;0
WireConnection;89;1;109;0
WireConnection;184;0;176;0
WireConnection;184;1;192;0
WireConnection;97;0;105;0
WireConnection;97;1;92;1
WireConnection;197;0;168;0
WireConnection;197;1;191;0
WireConnection;442;0;441;0
WireConnection;442;1;440;0
WireConnection;179;0;165;0
WireConnection;179;1;190;0
WireConnection;443;0;442;0
WireConnection;71;0;64;0
WireConnection;71;1;61;0
WireConnection;103;0;100;0
WireConnection;103;1;97;0
WireConnection;317;0;311;0
WireConnection;317;5;320;0
WireConnection;96;0;102;0
WireConnection;96;1;112;0
WireConnection;174;0;181;0
WireConnection;174;1;184;0
WireConnection;418;0;408;0
WireConnection;418;1;219;0
WireConnection;194;0;179;0
WireConnection;194;1;168;0
WireConnection;194;2;197;0
WireConnection;115;0;117;0
WireConnection;115;1;89;0
WireConnection;407;0;218;0
WireConnection;407;1;406;1
WireConnection;75;0;73;0
WireConnection;220;0;407;0
WireConnection;220;1;418;0
WireConnection;339;0;317;0
WireConnection;90;0;115;0
WireConnection;91;0;103;0
WireConnection;91;1;96;0
WireConnection;58;1;71;0
WireConnection;58;0;64;0
WireConnection;186;0;174;0
WireConnection;186;1;194;0
WireConnection;113;0;90;0
WireConnection;113;1;91;0
WireConnection;444;0;58;0
WireConnection;444;1;445;0
WireConnection;173;0;186;0
WireConnection;173;1;183;0
WireConnection;18;0;220;0
WireConnection;18;1;86;0
WireConnection;76;1;75;0
WireConnection;76;0;64;0
WireConnection;337;0;340;0
WireConnection;81;0;18;0
WireConnection;332;0;341;0
WireConnection;111;1;113;0
WireConnection;77;0;76;0
WireConnection;189;1;173;0
WireConnection;78;0;444;0
WireConnection;334;0;342;0
WireConnection;334;1;335;0
WireConnection;419;0;332;0
WireConnection;419;1;420;0
WireConnection;193;0;189;0
WireConnection;121;0;111;0
WireConnection;338;0;334;0
WireConnection;338;1;337;0
WireConnection;67;1;84;0
WireConnection;67;2;79;0
WireConnection;46;1;83;0
WireConnection;46;2;80;0
WireConnection;347;0;419;0
WireConnection;429;0;428;0
WireConnection;345;0;338;0
WireConnection;60;0;46;0
WireConnection;60;1;67;0
WireConnection;60;2;123;0
WireConnection;60;3;202;0
WireConnection;431;0;429;0
WireConnection;333;0;60;0
WireConnection;333;1;346;0
WireConnection;333;2;348;0
WireConnection;432;0;430;0
WireConnection;432;1;431;0
WireConnection;433;1;432;0
WireConnection;321;0;60;0
WireConnection;321;1;333;0
WireConnection;329;0;321;0
WireConnection;434;0;433;0
WireConnection;305;0;304;4
WireConnection;0;2;435;0
WireConnection;0;13;331;0
ASEEND*/
//CHKSM=6A8D7B8D738B9454F3F1E53F9AC9ED1C50614AD4