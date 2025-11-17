# First‑Time Setup on a DGX Spark

When you receive access to a DGX Spark or similar DGX workstation, there are a few steps you should take before running workloads. This guide covers initial housekeeping and configuration to get you productive quickly.

## 1. Connect to the machine

Depending on your environment, you might access the DGX via physical keyboard and monitor, or over SSH:

* **Local login:** Simply log in at the console with your username and password.
* **Remote login:** On your laptop run:

  ```bash
  ssh your_user@dgx-hostname
  ```

  Replace `your_user` with your username and `dgx-hostname` with the DGX’s hostname or IP address.

## 2. Update the OS and packages

Bring the system packages up to date. This ensures you have the latest security patches and bug fixes.

```bash
sudo apt update
sudo apt upgrade -y
```

On some DGX installations, updates are managed through NVIDIA’s DGX OS packaging. If you are running DGX OS, use the `sudo dgx-release-updater` tool and follow your administrator’s instructions.

## 3. Check GPU drivers and CUDA

Verify that the NVIDIA drivers are installed and that CUDA libraries are present:

```bash
nvidia-smi
nvcc --version
```

`nvidia-smi` should list one or more GPUs with driver version and utilisation. If `nvcc` is not found, the CUDA toolkit might not be installed; you can still run PyTorch or TensorFlow that includes its own CUDA runtime.

## 4. Create your workspace directories

Organise your files under your home directory. For example:

```bash
mkdir -p ~/projects ~/datasets ~/models
```

You can create a directory for virtual environments (`~/venv`) if you plan to use Python.

## 5. Set up SSH keys (optional)

If you frequently connect to the DGX over SSH, consider creating an SSH key pair and adding your public key to the server’s `~/.ssh/authorized_keys`. On your local machine:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-copy-id your_user@dgx-hostname
```

This allows passwordless authentication and better security.

## 6. Install common development tools

If not already installed, you may want to add tools such as Git, Python, and editors:

```bash
sudo apt install build-essential git wget curl python3 python3-pip python3-venv htop tmux -y
```

### Python virtual environments

Creating a virtual environment isolates your Python packages and avoids conflicts with system packages:

```bash
python3 -m venv ~/venv
source ~/venv/bin/activate
pip install --upgrade pip
```

## 7. Configure bash or zsh

If you prefer `zsh` over `bash`, you can install and set it as your default shell:

```bash
sudo apt install zsh -y
chsh -s $(which zsh)
```

Add your favourite aliases and prompt customisations to `~/.bashrc` or `~/.zshrc`. See `ubuntu-basics/useful_aliases.md` for examples.

## 8. Backup important data

DGX machines often host large datasets and models. Ensure you have a backup strategy:

* Use `rsync` to synchronise files to a remote server.
* Store critical scripts in version control systems like Git.

## Conclusion

Taking these steps on day one sets a solid foundation for working on your DGX. After completing the setup, explore the other guides in this repository to learn more about GPUs, Python environments and productivity tips.