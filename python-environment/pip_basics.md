# Pip Basics

`pip` is the package installer for Python. It allows you to install and manage additional libraries that are not part of the standard Python distribution. This guide covers common pip commands and best practices for working on a DGX.

## Installing packages

Activate your virtual environment before installing packages. To install a single package:

```bash
pip install pandas
```

To install a specific version:

```bash
pip install torch==2.1.1
```

You can list multiple packages separated by spaces:

```bash
pip install numpy scipy scikit-learn
```

## Upgrading packages

To upgrade an existing package to the latest version:

```bash
pip install --upgrade pandas
```

## Uninstalling packages

To remove a package from your environment:

```bash
pip uninstall package_name
```

## Listing installed packages

View all installed packages and their versions:

```bash
pip list
```

## Searching for packages

To search the Python Package Index (PyPI) for packages matching a keyword:

```bash
pip search "neural network"
```

Note: `pip search` relies on the deprecated XML‑RPC API and may be removed in future versions. Use <https://pypi.org/> for an up‑to‑date search.

## Requirements files

You can save a list of your environment’s packages to a file and recreate the environment elsewhere.

### Generating `requirements.txt`

Within an activated virtual environment:

```bash
pip freeze > requirements.txt
```

### Installing from a requirements file

On another machine or environment, run:

```bash
pip install -r requirements.txt
```

This ensures the same package versions are installed.

## Installing from alternative indexes or sources

DGX users may need to install packages built for specific CUDA versions. Many libraries, such as PyTorch and TensorFlow, provide pre‑built wheels on custom package indexes. For example:

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

Replace `cu118` with the CUDA version matching your system. Consult the library’s installation instructions for details.

## Tips

* Always activate your virtual environment before running pip commands.
* Avoid using `sudo pip` — install packages globally only when absolutely necessary.
* Keep your packages up to date, but test upgrades in a separate environment to avoid breaking existing projects.

For more information, see the pip documentation at <https://pip.pypa.io/>.