# System Monitoring on a DGX

Keeping an eye on CPU, memory, disk and GPU utilisation helps you diagnose bottlenecks and manage resources effectively. Ubuntu provides several built‑in tools as well as third‑party utilities. This note lists a few recommended methods.

## CPU and memory

* **htop** — interactive system monitor:

  ```bash
  sudo apt install htop -y
  htop
  ```

  `htop` displays CPU cores, memory usage, swap, running processes and their resource usage. Use the arrow keys to navigate; press `F6` to sort by different metrics and `F10` to exit.

* **free** — display memory usage:

  ```bash
  free -h
  ```

  Shows total, used and free memory in human‑readable units.

* **vmstat** — virtual memory statistics:

  ```bash
  vmstat 5
  ```

  Prints system statistics (processes, memory, swap, I/O) every 5 seconds.

## Disk I/O

* **df** — disk usage:

  ```bash
  df -h
  ```

  Lists all mounted filesystems and their usage.

* **du** — directory usage:

  ```bash
  du -sh ~/datasets
  ```

  Shows the total size of a specific directory (`~/datasets` in this example).

* **iostat** — CPU and I/O statistics:

  ```bash
  sudo apt install sysstat -y
  iostat -xz 5
  ```

  Reports CPU utilisation and per‑device I/O every 5 seconds.

## GPU monitoring

* **nvidia‑smi** — GPU status:

  See `nvidia_smi_basics.md` for detailed usage. For monitoring with refresh, use `watch -n 1 nvidia-smi`.

* **nvtop** — top‑like monitor for NVIDIA GPUs:

  ```bash
  sudo apt install nvtop -y
  sudo nvtop
  ```

  Displays GPU utilisation, memory usage and processes in an interactive interface. Requires kernel headers and is supported on many DGX systems.

## Process management

* **top** — built‑in process monitor:

  ```bash
  top
  ```

  Shows processes sorted by CPU usage. Press `M` to sort by memory, `P` to return to CPU, `q` to quit.

* **ps** — process status:

  ```bash
  ps aux | sort -nrk 3 | head
  ```

  Lists processes sorted by CPU usage (descending). Replace `3` with `4` to sort by memory usage.

## Logging and system journals

* **journalctl** — view system logs (requires root or user privileges):

  ```bash
  sudo journalctl -xe
  ```

  Shows recent system logs with details on errors and warnings.

* **dmesg** — kernel ring buffer:

  ```bash
  dmesg | tail
  ```

  Provides recent kernel messages, useful for diagnosing hardware issues.

## Conclusion

Understanding your system’s resource usage is vital for efficient DGX operation. Use these tools to identify bottlenecks, plan resource allocation and ensure your experiments run smoothly.