# Python Environment Troubleshooting

Working with virtual environments on a DGX is usually straightforward, but occasionally you may run into issues. This document provides solutions for common problems encountered when creating or using Python environments.

## `python3: command not found`

If `python3` isn’t found, the Python interpreter may not be installed or your PATH may not include it. Install Python and the `venv` module with:

```bash
sudo apt update
sudo apt install python3 python3-venv python3-pip -y
```

## `pip: command not found`

Even with Python installed, `pip` may be missing. Install it with:

```bash
sudo apt install python3-pip -y
```

Alternatively, use `python3 -m pip install package_name` to ensure you’re invoking pip associated with Python 3.

## `python3 -m venv venv` fails with `ensurepip` error

If you see an error about `ensurepip` or `No module named venv`, the `python3-venv` package is missing. Install it:

```bash
sudo apt install python3-venv -y
```

Then retry creating the environment.

## Unable to activate the environment (`command not found: activate`)

If `source venv/bin/activate` produces an error like `No such file or directory`, ensure you’re running the command in the correct directory. For example, if your environment is in `~/venv` you should run:

```bash
source ~/venv/bin/activate
```

If the `activate` script is missing, the environment may not have been created properly. Remove the directory and recreate it with `python3 -m venv ...`.

## `Permission denied` when installing packages

If you attempt to install packages globally without using a virtual environment, you may see permission errors. Always activate a virtual environment before installing, or use `sudo` only when upgrading system packages.

Within a virtual environment, you should never need `sudo` to install Python packages.

## CUDA-related import errors

When installing libraries like PyTorch or TensorFlow on a DGX, ensure you choose the build that matches your CUDA version. Example for PyTorch (substitute the correct CUDA version tag):

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

If you see `RuntimeError: CUDA error: ...` or `libcudart.so not found`, verify that your NVIDIA driver and CUDA runtime versions are compatible. You may need to update the driver or use a different Python wheel.

## Conflicts between conda and pip

Avoid mixing `conda install` and `pip install` in the same environment when possible. If you use conda, prefer conda packages; otherwise create separate environments for pip-based installations.

## Further help

Check official documentation:

* Python virtual environments: <https://docs.python.org/3/tutorial/venv.html>
* Pip user guide: <https://pip.pypa.io/en/stable/>
* Conda user guide: <https://conda.io/projects/conda/en/latest/user-guide/index.html>

If you continue to experience issues on a DGX, search for the error message or consult your system administrator.