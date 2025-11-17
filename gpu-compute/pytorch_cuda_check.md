# Checking CUDA Availability in PyTorch

`torch.cuda.is_available()` returns whether CUDA is accessible. Use the following techniques to confirm PyTorch sees your GPUs and perform a basic test on your DGX.

## 1. Verify PyTorch installation and CUDA support

In a Python interpreter within your virtual environment, run:

```python
import torch
print(torch.__version__)
print(torch.cuda.is_available())
```

The first line prints the PyTorch version. The second prints `True` if CUDA is available. If it returns `False`, PyTorch may have been installed without GPU support. Reinstall using the appropriate CUDA wheel (see `run_llm_locally.md`).

## 2. List available CUDA devices

Use the following script to list GPUs and their names:

```python
import torch

if torch.cuda.is_available():
    num_devices = torch.cuda.device_count()
    print(f"Number of CUDA devices: {num_devices}")
    for i in range(num_devices):
        print(f"Device {i}: {torch.cuda.get_device_name(i)}")
else:
    print("CUDA is not available")
```

This prints each detected GPU’s index and model name (e.g. `NVIDIA A100-SXM4-40GB`).

## 3. Test a simple GPU operation

Performing a matrix multiplication on the GPU ensures that computations execute correctly:

```python
import torch
import time

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
print(f"Using device: {device}")

a = torch.rand((10000, 10000), device=device)
b = torch.rand((10000, 10000), device=device)

# Ensure previous operations have finished
torch.cuda.synchronize()

start = time.time()
c = torch.matmul(a, b)
torch.cuda.synchronize()

print(f"Matrix multiplication took {time.time() - start:.3f} seconds")
```

On an A100 GPU this operation should complete in well under one second.

## 4. Check CUDA runtime version

To see the CUDA runtime version that your PyTorch build expects:

```python
import torch
print(torch.version.cuda)
```

Compare this version to the driver’s CUDA version reported by `nvidia‑smi`. The driver must be equal to or newer than the runtime version. Otherwise, update your driver or install a PyTorch build targeting an older CUDA version.

## Troubleshooting

* **`torch.cuda.is_available()` returns `False`:** The CPU‑only version of PyTorch may have been installed, or the NVIDIA driver installation may be faulty. Reinstall PyTorch with CUDA support and verify your driver is installed correctly.
* **`RuntimeError: CUDA error: out of memory`:** Reduce tensor sizes, free memory via `torch.cuda.empty_cache()`, or use half precision (`float16`).
* **Mismatched CUDA versions:** If PyTorch was built with a different CUDA version than your driver, install the correct wheel (e.g. `pip install torch==<version>+cu118`).

Refer to the [PyTorch CUDA semantics](https://pytorch.org/docs/stable/notes/cuda.html) for more details.