// Run: %dxc -T ps_6_0 -E main

// Ensure NonUniformEXT decoration is traced back to the load operation of the underlying variable/resource.

Texture2D           gTextures[32];
SamplerState        gSamplers[32];
RWStructuredBuffer<uint> sb;

float4 main(uint index : A, float2 loc : B) : SV_Target {

  uint arr[4][5];
  float4 v1 = gTextures[NonUniformResourceIndex(index + arr[index][4] + 1 + sb[index + 2])].Sample(gSamplers[0], loc);

  return v1;
}

// CHECK:      OpDecorate [[nu1:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu2:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu3:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu4:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu5:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu6:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu7:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu8:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu9:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu10:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu11:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu12:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu13:%\d+]] NonUniformEXT
// CHECK:      OpDecorate [[nu14:%\d+]] NonUniformEXT
// ...
// CHECK:  [[nu1]] = OpLoad %uint %index
// CHECK:  [[nu2]] = OpLoad %uint %index
// CHECK:  [[nu3]] = OpAccessChain %_ptr_Function_uint %arr [[nu2]] %int_4
// CHECK:  [[nu4]] = OpLoad %uint [[nu3]]
// CHECK:  [[nu5]] = OpIAdd %uint [[nu1]] [[nu4]]
// CHECK:  [[nu6]] = OpIAdd %uint [[nu5]] %uint_1
// CHECK:  [[nu7]] = OpLoad %uint %index
// CHECK:  [[nu8]] = OpIAdd %uint [[nu7]] %uint_2
// CHECK:  [[nu9]] = OpAccessChain %_ptr_Uniform_uint %sb %int_0 [[nu8]]
// CHECK: [[nu10]] = OpLoad %uint [[nu9]]
// CHECK: [[nu11]] = OpIAdd %uint [[nu6]] [[nu10]]
// CHECK: [[nu12]] = OpAccessChain %_ptr_UniformConstant_type_2d_image %gTextures [[nu11]]
// CHECK: [[nu13]] = OpLoad %type_2d_image [[nu12]]
// CHECK: {{%\d+}} = OpAccessChain %_ptr_UniformConstant_type_sampler %gSamplers %int_0
// CHECK: {{%\d+}} = OpLoad %type_sampler {{%\d+}}
// CHECK: {{%\d+}} = OpLoad %v2float %loc
// CHECK: [[nu14]] = OpSampledImage %type_sampled_image [[nu13]] {{%\d+}}
// CHECK: {{%\d+}} = OpImageSampleImplicitLod %v4float {{%\d+}} {{%\d+}} None
// CHECK:            OpStore %v1 {{%\d+}}

