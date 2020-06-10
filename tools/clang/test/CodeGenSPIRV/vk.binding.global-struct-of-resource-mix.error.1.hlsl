// Run: %dxc -T ps_6_0 -E main -fspv-flatten-resource-arrays

struct S {
  Texture2D t[2];
  SamplerState s[3];
  float a;
};

float4 tex2D(S x, float2 v) { return x.t[0].Sample(x.s[0], v); }

// CHECK: 12:3: error: global structures containing both resources and non-resources are unsupported
S globalS[2];

float4 main() : SV_Target {
  return tex2D(globalS[0], float2(0,0));
}

