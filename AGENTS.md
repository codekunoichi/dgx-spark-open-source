# Repository Guidelines

This repo is a collection of DGX Spark notes and scripts. Keep changes concise, reproducible, and beginner-friendly.

## Project Structure & Module Organization
- `ubuntu-basics/`: Ubuntu tips, aliases, and shortcuts.
- `dgx-setup/`: DGX onboarding, GPU driver steps, `nvidia-smi`, and monitoring.
- `python-environment/`: Virtualenv creation, `pip` usage, and troubleshooting.
- `gpu-compute/`: CUDA checks, GPU benchmarks, and local LLM tips.
- `tips-tricks/`: Productivity aliases, shortcuts, and recommended apps.
- `README.md`: High-level overview; update when adding new folders or guides.

## Build, Test, and Development Commands
- Markdown-only project; no build pipeline. Preview docs locally with `less file.md` or your editor’s Markdown preview.
- Validate any command you document on a DGX with Ubuntu before publishing; include expected output snippets when helpful.
- Use `git status` before committing to ensure only intended files are staged.

## Coding Style & Naming Conventions
- Write in Markdown; use `#`/`##` headings, short bullet lists, and fenced code blocks with language tags (e.g., ```bash).
- Keep tone instructional and concise; prefer command-first steps over prose.
- File names: lowercase with hyphens (e.g., `python_env_troubleshooting.md` matches existing pattern).
- For code/commands, favor DGX/Ubuntu defaults; call out prerequisites explicitly.

## Testing Guidelines
- Run every command you add; note GPU/driver assumptions and expected output (e.g., `nvidia-smi` table shape).
- When adding scripts, keep them idempotent and comment anything DGX-specific.
- If instructions are OS-conditional, state the environment (Ubuntu version, shell).

## Commit & Pull Request Guidelines
- Follow existing convention from history (e.g., `docs: Add personal context of why this repo was created`); use imperative, scoped prefixes like `docs:`, `chore:`, `scripts:`.
- Commits should be small and focused on one guide or script.
- PRs: include a short summary, linked issue if applicable, and list which commands you ran to verify (screenshots optional but helpful for UI/output).

## Security & Configuration Tips
- Do not commit secrets, API keys, or machine identifiers from DGX hosts.
- Redact hostnames, IPs, and paths that are user-specific; prefer generic placeholders.
- When sharing logs, trim to minimal lines that illustrate the point.
