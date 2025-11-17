# Useful Aliases for Your Shell

Aliases allow you to create short commands that expand into longer ones. They are stored in your shell’s configuration file (commonly `~/.bashrc` or `~/.zshrc`) and are loaded each time you open a terminal.

Below are some handy aliases that can make working on a DGX or any Ubuntu system more efficient. Feel free to customise the names and paths to suit your workflow.

## Adding an alias

1. Open your shell configuration file in an editor, for example:

   ```bash
   nano ~/.bashrc
   ```

2. Scroll to the bottom and add your alias definitions, one per line:

   ```bash
   alias ll='ls -alF'
   alias la='ls -A'
   alias l='ls -CF'
   ```

3. Save and close the file.

4. Reload the configuration in your current shell:

   ```bash
   source ~/.bashrc
   ```

Now your aliases are ready for use.

## Suggested aliases

| Alias | Expansion | Description |
| --- | --- | --- |
| `ll` | `ls -alF` | List files in long format, show hidden files, append `/` to directories. |
| `la` | `ls -A` | List files, including hidden files, but exclude `.` and `..`. |
| `l` | `ls -CF` | Column view listing with file type indicators. |
| `gpu` | `watch -n 1 nvidia-smi` | Continuously monitor GPU status every second. |
| `update` | `sudo apt update && sudo apt upgrade -y` | Refresh package lists and upgrade installed packages. |
| `pyenv` | `source ~/venv/bin/activate` | Activate a Python virtual environment located at `~/venv`. Change this path to your environment. |
| `desk` | `cd ~/Desktop` | Quickly jump to the Desktop directory. |
| `gs` | `git status` | Short command to check Git status. |
| `gc` | `git commit` | Shortcut for committing changes. |
| `gpl` | `git pull` | Pull the latest changes from the remote repository. |
| `gps` | `git push` | Push commits to the remote repository. |

## Removing an alias

To temporarily disable an alias in the current session, use `unalias` followed by the alias name:

```bash
unalias ll
```

To remove it permanently, delete or comment out the line in your configuration file.

## Making the cheat sheet easily accessible

If you've created a cheat sheet file (for example, `~/Desktop/ubuntu_cheatsheet.txt`), you can add an alias to open it quickly:

```bash
alias cheat='nano ~/Desktop/ubuntu_cheatsheet.txt'
```

After reloading your `~/.bashrc`, simply run `cheat` to view or edit the file.