Shader "Unlit/warFogSimulation"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	CGINCLUDE
	#include "UnityCustomRenderTexture.cginc"
	sampler2D _MainTex;
	float4 frag(v2f_customrendertexture i) : COLOR
	{
		//需要开启double buffer来读取上一次结果，但process后对上次的zone区域也有影响，原因不明

		//fixed4 self = tex2D(_SelfTexture2D, i.globalTexcoord.xy);
		fixed4 decal = tex2D(_MainTex, i.localTexcoord.xy);
		return decal;// * decal.a；// + self * (1 - decal.a);
		//return tex2D(_MainTex, i.globalTexcoord.xy);
		//return float4(1,1,0,0);
	}

	float4 frag_update(v2f_customrendertexture i) : COLOR
	{
		return tex2D(_SelfTexture2D, i.globalTexcoord.xy);
	}

	ENDCG

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			//crt 可以直接使用传统的blend 来进行混合
			Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM
			#pragma vertex CustomRenderTextureVertexShader
			#pragma fragment frag			
			ENDCG
		}
	}
}
