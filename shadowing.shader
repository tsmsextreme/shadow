Shader "Unlit/shadowing"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"  "Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha 
        LOD 100

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
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                if(col.r != 0 || col.g != 1 || col.b != 0){
                    discard;
                }
                fixed4 col2 = tex2D(_MainTex, i.uv + float2(0.00, 0.01));
                fixed4 col3 = tex2D(_MainTex, i.uv + float2(0.01, 0.00));
                fixed4 col4 = tex2D(_MainTex, i.uv + float2(-0.01, 0.00));
                fixed4 col5 = tex2D(_MainTex, i.uv + float2(0.00, -0.01));
                return fixed4(0,0,0, (col.a + col2.a + col3.a + col4.a + col5.a)/5);
            }
            ENDCG
        }
    }
}
