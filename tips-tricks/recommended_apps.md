# Recommended Applications and Tools

The DGX ecosystem supports a wide range of software. Beyond built‑in Ubuntu tools, here are some applications that can enhance productivity, development and monitoring on your DGX.

## Development environments

* **Visual Studio Code** – a powerful, extensible code editor with Python and remote SSH extensions.
  * Install via Snap: `sudo snap install --classic code`
  * Or via `.deb`: download from <https://code.visualstudio.com>.
  * Use the [Remote SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) to edit files on your DGX from your laptop.

* **PyCharm** – full‑featured Python IDE (community edition is free). Download from <https://www.jetbrains.com/pycharm/download/>.

* **JupyterLab** – interactive notebooks and web‑based IDE. Install with:

  ```bash
  pip install jupyterlab
  jupyter lab
  ```

  For remote access, run JupyterLab in a screen or tmux session and set a password or token.

## Terminal utilities

* **tmux** – terminal multiplexer that allows multiple terminal sessions in one window. Start with `tmux new -s mysession` and detach with `Ctrl + B` then `D`.

* **Oh My Zsh** – framework for managing zsh configuration, includes themes and plugins. Install with:

  ```bash
  sudo apt install zsh git -y
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  ```

  Choose `zsh` as your login shell: `chsh -s $(which zsh)`.

* **bat** – modern `cat` with syntax highlighting and git integration. Install:

  ```bash
  sudo apt install bat -y
  # On some distributions the binary is named batcat
  alias bat=batcat
  ```

* **exa** – modern replacement for `ls` with colours and git support. Install:

  ```bash
  sudo apt install exa -y
  alias ls='exa'
  ```

## Monitoring tools

* **nvtop** – interactive GPU monitor (see `dgx-setup/system_monitoring.md`).
* **gpustat** – Python script to display GPU usage in a friendly format. Install via `pip install gpustat` and run `gpustat`.
* **Glances** – cross‑platform monitoring tool with a web UI. Install with `sudo apt install glances -y`.

## Data transfer and backup

* **rsync** – efficient file synchronisation tool. Use `rsync -av --progress source/ destination/` to copy directories.
* **rclone** – command‑line program to sync files to cloud storage services (Google Drive, S3, etc.). See <https://rclone.org> for installation and configuration.

## Miscellaneous

* **Flameshot** – screenshot tool with annotation. Install via `sudo apt install flameshot -y`.
* **htop** – improved process viewer (see `dgx-setup/system_monitoring.md`).

These tools can greatly improve your workflow on DGX. Feel free to suggest additions via pull requests.