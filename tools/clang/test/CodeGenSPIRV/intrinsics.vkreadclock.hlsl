// Run: %dxc -T vs_6_0 -E main

// CHECK: OpCapability ShaderClockKHR
// CHECK: OpExtension "SPV_KHR_shader_clock"

//namespace vk {
//void foo() {}
//}

//namespace xx {
//void foo() {}
//}

float4 main(const float4 v : A) : SV_Position {
  //floor(1.0);

  //xx::foo();
  vk::foo();

  //VkInvocationScope();
  //uint64_t clock = vk::ReadClock(VkCrossDeviceScope());

  return 0.xxxx;
}

