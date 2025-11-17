# Terminal Shortcuts and Tips

Working efficiently in the terminal is a key skill when using a DGX or any Linux system. This note collects handy key combinations and commands that help you navigate, edit and manage tasks without taking your hands off the keyboard.

## Basic navigation

| Shortcut | Description |
| --- | --- |
| `Ctrl + A` | Move the cursor to the start of the current command line. |
| `Ctrl + E` | Move the cursor to the end of the line. |
| `Ctrl + U` | Delete everything from the cursor to the beginning of the line. |
| `Ctrl + K` | Delete everything from the cursor to the end of the line. |
| `Alt + F` | Move forward one word. |
| `Alt + B` | Move backward one word. |
| `Ctrl + W` | Cut the word before the cursor. |
| `Ctrl + Y` | Paste the most recently cut text. |
| `Tab` | Autocomplete a file or command name. |

You can combine Tab autocompletion with `cd` and `ls` to quickly move around your filesystem.

## Command history

The Bash shell remembers previously executed commands. Use this to your advantage:

| Shortcut | Description |
| --- | --- |
| `Up Arrow` | Display the previous command in history. Repeat to go further back. |
| `Down Arrow` | Move forward in history after going back. |
| `Ctrl + R` | Reverse incremental search: type part of a command and Bash will search your history for matching commands. Press `Ctrl + R` repeatedly to cycle through matches. |
| `history` | Show the command history with line numbers. |
| `!n` | Execute the command numbered `n` in history. |
| `!!` | Execute the last command again (useful after prefixing with `sudo`, e.g. `sudo !!`). |

## Job control

When running long commands, you may want to pause, resume or run them in the background.

| Shortcut/Command | Description |
| --- | --- |
| `Ctrl + C` | Terminate the current process (send SIGINT). |
| `Ctrl + Z` | Suspend the current process (send SIGTSTP). |
| `fg` | Bring the most recently suspended process back to the foreground. |
| `bg` | Resume a suspended job in the background. |
| `jobs` | List jobs running in the current shell. |

## Working with multiple terminals

* **Open a new terminal tab:** `Ctrl + Shift + T`.
* **Open a new terminal window:** `Ctrl + Shift + N`.
* **Navigate between tabs:** `Ctrl + Page Up` and `Ctrl + Page Down`.

## Miscellaneous tips

* Use `man <command>` to read the manual page for a command. For example, `man ls` shows all options for `ls`.
* Press `q` to quit manual pages or other pagers such as `less`.
* Use `Ctrl + L` to clear the terminal screen without losing your scrollback history. This is equivalent to running the `clear` command.
* Press `Ctrl + D` at an empty prompt to log out of your shell or close the terminal.
* Use `sudo !!` to re-run the previous command with administrative privileges.

Learning these shortcuts will significantly speed up your workflow. Feel free to add your own notes and favourite shortcuts here.