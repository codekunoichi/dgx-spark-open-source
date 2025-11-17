# Benchmarking Your DGX GPU

Understanding your GPU’s performance helps you size workloads, diagnose issues and compare different hardware. This guide outlines simple methods to benchmark a DGX GPU using built‑in tools and open‑source benchmarks. These tests are synthetic; real‑world performance will depend on your application.

## Warning

Benchmarks can stress hardware significantly. Ensure proper cooling and avoid running benchmarks on shared production machines during critical tasks.

## 1. Use `nvidia‑smi` counters

While not a benchmark, `nvidia‑smi` provides instantaneous utilisation metrics. You can record GPU utilisation and memory usage while running your workload to understand its behaviour.

```bash
watch -n 1 nvidia-smi
```

## 2. GPU Burn

`gpu‑burn` is a small CUDA program that stresses the GPU to maximum utilisation. Install prerequisites:

```bash
sudo apt install git make gcc nvcc -y
git clone https://github.com/wilicc/gpu-burn.git
cd gpu-burn
make
```

Run the benchmark for 1 minute on all GPUs:

```bash
./gpu_burn 60
```

Output shows per‑GPU Gflops and temperature. Compare results with manufacturer specifications. Be cautious: this tool will fully load the GPUs.

## 3. CUDA samples (`bandwidthTest` and `deviceQuery`)

The CUDA toolkit includes sample programs that measure memory bandwidth and device properties. Install the toolkit if needed (`sudo apt install nvidia-cuda-toolkit -y`) then run:

```bash
cd /usr/local/cuda*/samples/1_Utilities/bandwidthTest
sudo make
./bandwidthTest

cd ../deviceQuery
sudo make
./deviceQuery
```

`bandwidthTest` reports host‑to‑device and device‑to‑device bandwidth. `deviceQuery` prints device capabilities (compute capability, memory sizes, etc.).

## 4. PyTorch/TF micro‑benchmarks

For a framework‑level benchmark, you can write short scripts in PyTorch or TensorFlow to measure throughput. For example, in PyTorch:

```python
import torch
import time

device = torch.device('cuda:0')
batch = torch.randn(1024, 1024, device=device)
weights = torch.randn(1024, 1024, device=device)

# Warm‑up
for _ in range(10):
    _ = torch.matmul(batch, weights)

# Benchmark
start = time.time()
for _ in range(100):
    _ = torch.matmul(batch, weights)
torch.cuda.synchronize()
duration = time.time() - start

print(f"Average matrix multiplication time: {duration / 100:.6f} seconds")
```

Adjust matrix sizes and iterations based on available memory and desired accuracy. This script measures average matrix multiplication time, which is compute‑heavy and will use FP32 by default. For FP16, call `.half()` on the tensors.

## 5. Deep learning benchmarks

For more realistic tests, consider the [MLPerf](https://mlcommons.org/en/missions/training-overview/) benchmarks or vendor‑provided benchmarks for specific workloads (e.g. BERT, ResNet‑50). These require dataset preparation and longer runtimes but provide meaningful comparisons.

## Conclusion

Benchmarking is useful for verifying that your DGX GPUs perform as expected. Always interpret results in context: synthetic benchmarks may not reflect real‑world training workloads. Use them alongside application‑specific profiling to fully understand your system’s capabilities.