# Installing or Updating NVIDIA Drivers on a DGX

DGX systems typically ship with the correct NVIDIA drivers pre‑installed and configured. In most cases you should avoid upgrading GPU drivers unless there is a specific need (e.g. compatibility with newer CUDA libraries). Incorrect driver versions can lead to kernel mismatches, broken X sessions or reduced performance.

This guide outlines the general process for checking, installing and upgrading drivers on Ubuntu. Consult your system administrator or NVIDIA documentation before making changes on a production DGX.

## 1. Check current driver version

Run `nvidia-smi` to see the driver version:

```bash
nvidia-smi
```

Look at the “Driver Version” field. Note this value before changing anything. You can also see the CUDA version associated with the driver.

## 2. Identify recommended drivers

Ubuntu provides an `ubuntu-drivers` tool that suggests the best driver for your hardware:

```bash
sudo ubuntu-drivers devices
```

The output lists available driver packages and designates one as recommended. On many systems this will be something like `nvidia-driver-535` or similar. DGX machines may use special driver branches packaged by NVIDIA, in which case the tool may not show them.

## 3. Install drivers via APT (preferred)

If the recommended driver is suitable for your DGX and you want to upgrade, you can install it through the package manager. For example:

```bash
sudo apt install nvidia-driver-535 -y
```

Replace `535` with the recommended version. After installation, reboot the system:

```bash
sudo reboot
```

Verify with `nvidia-smi` that the new driver is active.

### DGX OS considerations

NVIDIA provides a DGX‑specific operating system (DGX OS) which includes a tested driver stack. If you run DGX OS, use the `sudo dgx-release-updater` tool to upgrade drivers and other DGX packages in a supported way.

## 4. Installing the CUDA toolkit

The CUDA toolkit (compiler, libraries, etc.) is separate from the driver. You can install it with:

```bash
sudo apt install nvidia-cuda-toolkit -y
```

Alternatively download the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) installer from NVIDIA. Choose the **DEB (local)** option for Ubuntu, follow the instructions on the website, and install both the driver and toolkit if you need a newer CUDA version for development.

## 5. Manual driver installation (runfile)

As a last resort, you can download and run NVIDIA’s `.run` installer. This method is more involved:

1. Download the `.run` file from [nvidia.com/Download/index.aspx](https://www.nvidia.com/Download/index.aspx).
2. Stop the graphical session (e.g. `sudo systemctl isolate multi-user.target`).
3. Run the installer with `sudo bash NVIDIA-Linux-x86_64-XXX.run`.
4. Follow the prompts and reboot when complete.

Manual installations can conflict with package‑managed drivers and should only be used when recommended by NVIDIA.

## 6. Troubleshooting

* **Black screen after upgrade:** Switch to a text console (`Ctrl + Alt + F3`), log in and check `/var/log/syslog` and `/var/log/Xorg.0.log` for errors. You may need to purge the new driver and reinstall an older one.
* **Mismatch between driver and CUDA version:** Applications may complain about missing `libcuda.so`. Verify that your software stack supports your driver version. Upgrading or downgrading either CUDA or the driver may be necessary.
* **DKMS build errors:** Driver packages compile kernel modules via DKMS. Ensure that the system has the required build tools (`build-essential`, `gcc`, `make`) and matching kernel headers (`linux-headers-$(uname -r)`).

If in doubt, consult NVIDIA DGX support or your system administrator. Updating drivers on production DGX machines is not to be taken lightly.