# Developer Shortcuts and Advanced Tips

This note collects various shortcuts and techniques to streamline development on a DGX. These go beyond basic commands and may require additional configuration.

## 1. Persistent terminal sessions with `tmux`

DGX workloads can run for hours or days. Keep your sessions alive and reconnectable:

```bash
tmux new -s mysession
```

* Detach: `Ctrl + B`, then press `D`.
* List sessions: `tmux ls`.
* Reattach: `tmux attach -t mysession`.

You can split panes (`Ctrl + B` then `%` or `"`), rename windows, and manage multiple projects in one session.

## 2. Mount remote filesystems with `sshfs`

Access your DGX files locally over SSH without copying them:

```bash
sudo apt install sshfs -y
mkdir -p ~/dgx_mount
sshfs your_user@dgx-hostname:/home/your_user ~/dgx_mount
```

You can now browse DGX files as if they were on your local machine. Unmount with `fusermount -u ~/dgx_mount`.

## 3. Git quality of life settings

Configure Git globally for better diffs and commit information:

```bash
git config --global core.editor "nano"
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
git config --global init.defaultBranch main
git config --global pull.rebase false

# Better diffs for notebooks and images
git config --global diff.nbdiffdriver.command "nbdiff"
```

Consider using [git‑lfs](https://git-lfs.github.com/) to version control large model weights or datasets.

## 4. Using `rsync` for backups

Synchronise directories efficiently, copying only changes:

```bash
rsync -avh --progress ~/projects user@backup-server:/backups/dgx/
```

Add the `--delete` flag to remove files on the destination that have been removed locally (be careful).

## 5. Creating custom scripts

Store frequently used commands in scripts under `~/bin` and add this directory to your PATH. For example, create a script `gpu_watch.sh`:

```bash
#!/bin/bash
watch -n 1 nvidia-smi
```

Make it executable and add to your PATH:

```bash
chmod +x ~/bin/gpu_watch.sh
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Now run `gpu_watch.sh` from anywhere.

## 6. Python debugging with `pdb`

Insert the following line in your Python code where you want to break into the debugger:

```python
import pdb; pdb.set_trace()
```

Run the script normally; execution will pause at that point, allowing you to inspect variables and step through code.

## 7. Jupyter over SSH tunnels

Run a notebook server on the DGX and forward it to your local browser:

1. On the DGX, launch Jupyter with a known port:

   ```bash
   jupyter lab --no-browser --port=8888
   ```

2. On your local machine, establish an SSH tunnel:

   ```bash
   ssh -N -f -L 8888:localhost:8888 your_user@dgx-hostname
   ```

3. Open <http://localhost:8888> in your local browser. Authenticate with the token printed by Jupyter.

## 8. environment modules

If your organisation uses the **Environment Modules** system, you can load preconfigured software stacks without polluting your environment. List available modules:

```bash
module avail
module load cuda/11.8
module unload cuda/11.7
```

Check with your administrators whether modules are available on your DGX.

## Conclusion

These shortcuts save time and reduce friction when developing on a DGX. Combine them with the basics from other guides to build a robust workflow.