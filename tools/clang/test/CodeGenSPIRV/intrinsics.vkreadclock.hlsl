// Run: %dxc -T vs_6_0 -E main

// CHECK: OpCapability ShaderClockKHR
// CHECK: OpExtension "SPV_KHR_shader_clock"

struct SInstanceData {
  float4x3 VisualToWorld;
  float4 Output;
};

struct VS_INPUT	{
  float3 Position : POSITION;
  SInstanceData	InstanceData : TEXCOORD4;
};

float4 main(const VS_INPUT v) : SV_Position {
	const SInstanceData	I = v.InstanceData;
  uint64_t clock;
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_0
  clock = VkReadClock(VkCrossDeviceScope());
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_1
  clock = VkReadClock(VkDeviceScope());
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_2
  clock = VkReadClock(VkWorkgroupScope());
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_3
  clock = VkReadClock(VkSubgroupScope());
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_4
  clock = VkReadClock(VkInvocationScope());
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_5
  clock = VkReadClock(VkQueueFamilyScope());
  return I.Output;
}

