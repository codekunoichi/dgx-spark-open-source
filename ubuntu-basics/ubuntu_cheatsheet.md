# Ubuntu DGX Spark Cheat Sheet

This document summarises the most common commands and shortcuts you will use on a DGX workstation running Ubuntu. Keep it handy when you’re getting started.

## Cursor & Text Size

* **Increase mouse pointer size:**
  * **GUI:** open **Settings → Accessibility → Cursor Size** and adjust the slider.
  * **Terminal:** run `gsettings set org.gnome.desktop.interface cursor-size 48` to change the pointer size (replace `48` with your desired size).

* **Increase text scaling:**
  * Run `gsettings set org.gnome.desktop.interface text-scaling-factor 1.4` to scale up text. Replace `1.4` with a value between `1.0` and `2.0` depending on your preference.

## Keyboard shortcuts – Desktop

These shortcuts work in most GUI applications:

| Action | Shortcut |
| --- | --- |
| Copy | `Ctrl + C` |
| Paste | `Ctrl + V` |
| Cut | `Ctrl + X` |
| Undo | `Ctrl + Z` |
| Switch applications | `Alt + Tab` |
| Screenshot (Print Screen key) | `PrtSc` |

On compact keyboards without a dedicated Print Screen key, you can configure your own screenshot shortcut. See `screenshot_instructions.md` for details.

## Keyboard shortcuts – Terminal

The Terminal uses different modifiers than GUI applications:

| Action | Shortcut |
| --- | --- |
| Copy text | `Ctrl + Shift + C` |
| Paste text | `Ctrl + Shift + V` |
| Cancel running process | `Ctrl + C` |
| Clear screen | `Ctrl + L` |
| New tab | `Ctrl + Shift + T` |
| Close tab | `Ctrl + Shift + W` |
| Search in terminal | `Ctrl + Shift + F` |

## File navigation (Terminal)

| Command | Description |
| --- | --- |
| `ls` | List files in the current directory. |
| `ls -l` | Detailed list, including permissions, owner, size and modification date. |
| `ls -a` | Show hidden files (those starting with `.`). |
| `pwd` | Display the current directory path. |
| `cd folder` | Enter a folder. |
| `cd ..` | Go up one level. |
| `mkdir name` | Create a new directory. |
| `rm file` | Delete a file. |
| `rm -r folder` | Delete a directory recursively (use with caution). |
| `cp a b` | Copy file `a` to `b`. |
| `mv a b` | Move or rename `a` to `b`. |

## Editing files

* **Nano (simple text editor):**

  ```bash
  nano filename.txt
  ```

  *Save:* press `Ctrl + O`, then `Enter` to confirm.  
  *Exit:* press `Ctrl + X`.

* **Vim (more advanced):**

  ```bash
  vim filename.txt
  ```

* **Gedit (GUI):** if the desktop environment includes Gedit, you can open a file by running `gedit filename.txt &` from the terminal. The ampersand (`&`) returns you to the terminal immediately.

## System essentials

* **Update the system:**

  ```bash
  sudo apt update && sudo apt upgrade -y
  ```

  This downloads package lists and upgrades installed packages.

* **Install common tools:**

  ```bash
  sudo apt install git curl wget htop tree -y
  ```

  Installs Git, cURL, Wget, the `htop` system monitor and `tree` for directory trees.

* **Check GPU:**

  ```bash
  nvidia-smi
  ```

  Displays GPU utilisation, drivers and running processes.

* **Check disk usage:**

  ```bash
  df -h
  ```

  Shows disk usage of mounted filesystems in human‑readable format.

* **Open settings:**

  ```bash
  gnome-control-center
  ```

  Launches the GNOME Control Centre.

## GUI tricks

* **Open current folder in a file manager:**

  ```bash
  nautilus .
  ```

* **Show hidden files in the file manager:** press `Ctrl + H` while the file manager is open.

## SSH basics

* **Copy a local file to a DGX:**

  ```bash
  scp localfile.txt user@hostname:/path/to/destination/
  ```

* **Copy a file from a DGX to your local machine:**

  ```bash
  scp user@hostname:/path/to/file.txt .
  ```

Replace `user` with your username and `hostname` with the remote host’s name or IP address.

## Optional: quick alias

Add this line to your `~/.bashrc` file to create an alias that opens your cheat sheet:

```bash
alias cheat='nano ~/Desktop/ubuntu_cheatsheet.txt'
```

After editing, reload your shell with `source ~/.bashrc`. Typing `cheat` will then open the file at any time.