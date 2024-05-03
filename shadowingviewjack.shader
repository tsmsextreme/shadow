﻿Shader "Unlit/shadowingviewjack"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"  "Queue" = "Transparent-1"}
        LOD 100
        ZTest Always
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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {  
                int w = _ScreenParams.x;
                int h = _ScreenParams.y;
                if(w != h * 2){
                    discard;

                } 
                //fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 col = fixed4(0,1,0,1);
                return col;
            }
            ENDCG
        }
    }
}
