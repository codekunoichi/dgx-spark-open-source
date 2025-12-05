# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a documentation-only repository providing beginner-friendly guides, cheat sheets, and scripts for working with NVIDIA DGX Spark systems running Ubuntu. The target audience includes students, researchers, and engineers transitioning from macOS/Windows to DGX Ubuntu environments. The repository focuses on practical, reproducible instructions for GPU computing, Python environments, databases (PostgreSQL, Neo4j), and Ubuntu fundamentals.

## Repository Structure

- `ubuntu-basics/`: Ubuntu keyboard shortcuts, file navigation, terminal tips, and aliases
- `dgx-setup/`: First-time DGX setup, GPU driver installation, `nvidia-smi` usage, system monitoring
- `python-environment/`: Virtual environment creation with `venv`, pip usage, troubleshooting
- `postgresql/`: PostgreSQL installation on Ubuntu 24.04 ARM64, role/database setup, DBeaver connection
- `graphdb/`: Neo4j Docker setup, Cypher query patterns, knowledge graph experimentation (CMS NPI database project)
- `gpu-compute/`: GPU benchmarking, PyTorch CUDA checks, running LLMs locally
- `tips-tricks/`: Productivity aliases (`productivity_aliases.sh`), developer shortcuts, recommended apps
- `AGENTS.md`: Repository guidelines for contributors
- `README.md`: High-level overview and directory reference

## Key Technologies & Environments

- **Platform**: Ubuntu 24.04 (noble) on ARM64 architecture (DGX Spark)
- **Python**: Uses `venv` for virtual environments (located at `~/venv` by default)
- **Databases**:
  - PostgreSQL (local installation, default port 5432)
  - Neo4j (Dockerized, ports 7474 for browser, 7687 for Bolt protocol)
- **Docker**: Used for Neo4j containerization (`neo4j:5` ARM64 image)
- **GPU Tools**: NVIDIA drivers, `nvidia-smi`, CUDA, PyTorch

## Common Commands

### Python Environment
Always use virtual environments for Python work:
```bash
# Create venv
python3 -m venv ~/venv

# Activate
source ~/venv/bin/activate

# Deactivate
deactivate
```

### Neo4j (Docker)
```bash
# Start Neo4j container (example from neo4j_setup.md)
docker run \
  --name neo4j-npi \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/your_strong_password \
  -v ~/Projects/npi-knowledge-graph/docker/data:/data \
  -v ~/Projects/npi-knowledge-graph/docker/logs:/logs \
  -v ~/Projects/npi-knowledge-graph/docker/plugins:/plugins \
  -v ~/Projects/npi-knowledge-graph/data:/import \
  -d neo4j:5

# Container management
docker ps                    # Check running containers
docker stop neo4j-npi       # Stop container
docker start neo4j-npi      # Start container

# Access Neo4j Browser at http://localhost:7474
```

### PostgreSQL
```bash
# Connect to database
psql -h localhost -U ninja -d sparkdb

# Common psql commands (from inside psql):
# \du    - List roles
# \l     - List databases
# \q     - Quit
```

### GPU Monitoring
```bash
# Check GPU status
nvidia-smi

# Continuous monitoring (from productivity_aliases.sh)
watch -n 1 nvidia-smi
# Or use alias: gpu
```

### Productivity Aliases
Source `tips-tricks/productivity_aliases.sh` for shortcuts:
- `ll` - Long listing with file types
- `gpu` - Watch nvidia-smi continuously
- `pyenv` - Activate default venv
- `gs`, `ga`, `gc`, `gpl`, `gps` - Git shortcuts
- `mkcd <dir>` - Create directory and cd into it

## Documentation Standards

### Markdown Conventions
- Use `#`/`##` for headings
- Short bullet lists preferred over long prose
- Fenced code blocks with language tags (```bash, ```cypher, ```python)
- Keep tone instructional and concise
- Command-first steps over explanatory prose

### File Naming
- Lowercase with underscores: `python_env_troubleshooting.md`
- Match existing patterns in each directory
- Descriptive names indicating content

### Content Requirements
- All commands must be tested on DGX Ubuntu before publishing
- Include expected output snippets when helpful
- Call out prerequisites explicitly (GPU requirements, driver versions, Ubuntu version)
- Redact sensitive information (hostnames, IPs, API keys, user-specific paths)
- Use generic placeholders for machine-specific values

## Git Workflow

### Commit Message Format
Follow existing convention with scoped, imperative prefixes:
- `docs:` - Documentation changes (most common)
- `chore:` - Maintenance tasks
- `scripts:` - Script additions or modifications
- `fix:` - Bug fixes

Examples from history:
- `docs: Add Neo4j setup guide for DGX Spark environment`
- `docs: add postgresql entry and upcoming experiments`
- `fix: renamed file postgresql_setup.md`

### Commit Best Practices
- Small, focused commits (one guide or script per commit)
- Use `git status` before committing to verify staged files
- No secrets, API keys, or machine identifiers in commits

## Cypher Query Patterns (Neo4j)

Key patterns from `cypher_cheat_sheet.md`:

```cypher
# Create node (always creates new)
CREATE (p:Person {name: 'Tom Hanks'})

# Merge (find or create)
MERGE (p:Person {name: 'Tom Hanks'})

# Merge with timestamps
MERGE (p:Person {name:'Daniel Craig'})
ON CREATE SET p.createdAt = datetime()
ON MATCH  SET p.updatedAt = datetime()

# Relationships
MERGE (p:Person {name: 'Tom Hanks'})
MERGE (m:Movie  {title: 'Cloud Atlas'})
MERGE (p)-[:ACTED_IN {role:'Cloud'}]->(m)

# Delete with relationships
MATCH (p:Person {name:'Daniel Craig'})
DETACH DELETE p

# Constraints and indexes
CREATE INDEX person_name_index FOR (p:Person) ON (p.name)
CREATE CONSTRAINT person_name_unique FOR (p:Person) REQUIRE p.name IS UNIQUE
```

## Project-Specific Context

### Knowledge Graph Project
The repository includes an ongoing experiment with knowledge graphs using the CMS NPI (National Provider Identifier) database:
- Project location: `~/Projects/npi-knowledge-graph/`
- Folder structure: `docker/`, `data/`, `cypher/`, `python/`
- Goal: Create, query, and document learnings from healthcare provider knowledge graphs

### DGX Environment Assumptions
- ARM64 architecture (affects package selection, e.g., DBeaver tarball)
- Ubuntu 24.04 LTS (noble)
- Docker installed with user in `docker` group (no sudo needed)
- NVIDIA drivers and CUDA installed
- Python 3 with venv module available

## Testing & Validation

When adding new guides:
1. Run every command on actual DGX hardware
2. Note GPU/driver assumptions
3. Include expected output (e.g., `nvidia-smi` table format)
4. Test scripts for idempotency
5. Document OS-specific requirements (Ubuntu version, shell type)
6. Verify Docker commands work without sudo

## Security Considerations

- Never commit secrets, API keys, or credentials
- Redact hostnames, IPs, and user-specific paths in documentation
- Use placeholders: `your_strong_password`, `/path/to/...`
- Trim logs to minimal necessary lines
- Keep example data generic and non-sensitive
