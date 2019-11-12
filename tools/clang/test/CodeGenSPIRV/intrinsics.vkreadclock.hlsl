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
  clock = vk::ReadClock(vk::CrossDeviceScope);
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_1
  clock = vk::ReadClock(vk::DeviceScope);
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_2
  clock = vk::ReadClock(vk::WorkgroupScope);
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_3
  clock = vk::ReadClock(vk::SubgroupScope);
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_4
  clock = vk::ReadClock(vk::InvocationScope);
// CHECK: {{%\d+}} = OpReadClockKHR %ulong %uint_5
  clock = vk::ReadClock(vk::QueueFamilyScope);
  return I.Output;
}
