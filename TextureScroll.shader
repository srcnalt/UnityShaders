Shader "Custom/WaterShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SpeedX("Flow Speed X", Range(-1, 1)) = 0
		_SpeedY("Flow Speed Y", Range(-1, 1)) = 0
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _SpeedX;
			float _SpeedY;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				i.uv.x += _Time[1] * _SpeedX;
				i.uv.y += _Time[1] * _SpeedY;

				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
