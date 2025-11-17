# Creating a Python Virtual Environment

Virtual environments allow you to isolate Python packages for a specific project. This prevents dependency conflicts between projects and keeps your system Python installation clean. On a DGX running Ubuntu, you can create and manage virtual environments with the built‑in `venv` module or with tools like `conda`.

## Using `venv` (standard library)

1. **Ensure Python 3 and venv are installed**

   Most DGX systems have Python 3 installed. If not, install it along with the venv module:

   ```bash
   sudo apt update
   sudo apt install python3 python3-venv python3-pip -y
   ```

2. **Create the environment**

   Choose a directory for your virtual environment (commonly in your home directory). For example:

   ```bash
   python3 -m venv ~/venv
   ```

   This creates a directory named `venv` in your home folder containing a standalone Python interpreter and package manager.

3. **Activate the environment**

   To use the packages installed in this environment, activate it:

   ```bash
   source ~/venv/bin/activate
   ```

   After activation, your shell prompt typically shows the environment name in parentheses. Any Python packages you install now using `pip` will be isolated from the system installation.

4. **Upgrade pip and install packages**

   Within the activated environment, upgrade pip and install your required libraries:

   ```bash
   pip install --upgrade pip
   pip install numpy pandas torch
   ```

5. **Deactivate when finished**

   To exit the virtual environment and return to the system Python, run:

   ```bash
   deactivate
   ```

## Using `conda` (optional)

Some users prefer the `conda` package manager, which can handle both Python and non‑Python dependencies. To install Miniconda:

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

Follow the prompts and restart your shell. Then create and activate a new environment:

```bash
conda create -n myenv python=3.9
conda activate myenv
```

You can then install packages with `conda install` or `pip install`.

## Best practices

* **One environment per project:** avoid mixing dependencies across projects.
* **Record dependencies:** create a `requirements.txt` via `pip freeze > requirements.txt` or use `conda env export`.
* **Use version control:** commit your environment files to your repository to help reproduce your setup.

## Troubleshooting

If you encounter issues while creating or activating environments, see `python_env_troubleshooting.md` for common solutions.