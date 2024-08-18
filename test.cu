#include <iostream>

__global__ void setTrue(bool* status) { *status = true; }

void check(bool const* status) {
  std::cout << "sizeof(bool) is " << sizeof(bool) << '\n';
  std::cout << "value of status is " << static_cast<int>(*reinterpret_cast<const char*>(status)) << '\n';
  std::cout << "status is " << std::noboolalpha << *status << " (" << std::boolalpha << *status << ")\n";
  std::cout << "status == true:  " << (*status == true) << '\n';
  std::cout << "status != true:  " << (*status != true) << '\n';
  std::cout << "status == false: " << (*status == false) << '\n';
  std::cout << "status != false: " << (*status != false) << '\n';
  std::cout << '\n';
}

int main() {
  bool* status;
  cudaMallocHost(&status, sizeof(bool));
  *status = false;
  check(status);

  setTrue<<<1, 1>>>(status);
  cudaDeviceSynchronize();
  check(status);

  *status = true;
  check(status);
}
