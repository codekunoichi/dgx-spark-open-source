# Using `nvidia‑smi` on a DGX

`nvidia‑smi` (NVIDIA System Management Interface) is a command‑line tool for querying and controlling the GPU state. It comes with the NVIDIA driver and provides real‑time information about GPU utilisation, memory usage, temperature and running processes. On a DGX with multiple GPUs, it’s especially useful for monitoring training workloads.

## Basic usage

Simply run:

```bash
nvidia-smi
```

You’ll see a table containing:

* **GPU**: device index (0 to N‑1).
* **Name**: GPU model, e.g. `A100-SXM4-40GB`.
* **Persistence-M**: whether persistence mode is enabled.
* **Bus-Id**: PCI bus address.
* **Disp.A**: whether the GPU is attached to a display.
* **Memory-Usage**: current memory usage (used/total).
* **Utilization**: GPU utilisation percentage and memory controller utilisation.
* **Temperature**: temperature in Celsius.
* **Power-Draw**: current power draw and limit.

Below the table, you’ll see a list of processes using the GPU, including their PID, memory usage and command line.

## Watching GPU metrics continuously

To refresh the output periodically, use the `watch` command. For example, update every second:

```bash
watch -n 1 nvidia-smi
```

This is useful when training models to see real‑time GPU utilisation.

## Filtering for specific information

`nvidia‑smi` has various query options. For example:

* **List GPUs as JSON:**

  ```bash
  nvidia-smi --query-gpu=index,name,memory.total,memory.used,utilization.gpu --format=csv
  ```

  This prints a compact CSV with GPU index, name, total memory, used memory and utilisation.

* **List running compute processes:**

  ```bash
  nvidia-smi pmon -c 1
  ```

  Shows one update (`-c 1`) of processes and their GPU utilisation.

* **Enable persistence mode:**

  ```bash
  sudo nvidia-smi -pm 1
  ```

  Persistence mode keeps the driver loaded between jobs, reducing initialisation latency. This is often enabled by default on DGX systems.

## Managing applications

You can reset a GPU if it becomes unresponsive (use with caution, as it will abort jobs on that GPU):

```bash
sudo nvidia-smi --gpu-reset -i 0
```

Replace `0` with the index of the GPU you want to reset. Only use this if the system is idle or you are certain it won’t interrupt other users.

## Querying ECC errors

DGX GPUs support ECC (error‑correcting code) memory. To check for memory errors:

```bash
nvidia-smi --query-gpu=correctable_errors.uncorrectable,correctable_errors.aggregate --format=csv
```

Investigate any non‑zero counts, as they may indicate hardware issues.

## Conclusion

`nvidia‑smi` is an essential tool for monitoring the health and performance of your DGX. Explore the manual page (`man nvidia-smi`) or run `nvidia-smi --help` for a full list of options.