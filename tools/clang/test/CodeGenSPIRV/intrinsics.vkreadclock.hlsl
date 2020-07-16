// Run: %dxc -T vs_6_0 -E main

// CHECK: OpCapability ShaderClockKHR
// CHECK: OpExtension "SPV_KHR_shader_clock"

//namespace vk {
//void foo() {}
//}

#if 0
namespace xx {
void foo(uint x) {}
uint bar() { return 1; }
}
#endif

float4 main(const float4 v : A) : SV_Position {
  //floor(floor(1.0));

  //xx::foo(xx::bar());
  vk::ReadClock(vk::DeviceScope()); // WORKS
  vk::ReadClock(1u);

  uint64_t u = vk::ReadClock(1u);    // WORKS
  uint scope = vk::DeviceScope();    // WORKS
  uint64_t t = vk::ReadClock(scope); // WORKS

  return 0.xxxx;
}
