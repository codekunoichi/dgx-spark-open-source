


# Neo4j Setup Guide (DGX Spark Ubuntu)

## 0. Verify Docker Installation and Permissions

Before installing Neo4j, confirm that Docker is already installed and that your user has permission to run Docker without `sudo`.

### Check if Docker is installed:
```bash
docker --version
```

You should see a version like `Docker version 24.x.x`.

### Check if Docker daemon is running:
```bash
sudo systemctl status docker
```

Expected: `active (running)`.

If not running:
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### Check if your user is in the `docker` group:
```bash
groups
```

Ensure `docker` appears in the list.  
If not, add yourself:

```bash
sudo usermod -aG docker $USER
```

Then log out and back in for the permission to apply.

### Test Docker:
```bash
docker run hello-world
```

You should see a confirmation message that Docker is functioning correctly.

This document captures the exact steps used to install and run Neo4j on the DGX Spark workstation, fully containerized using Docker and organized inside the `Projects` folder structure.

---

## 1. Create the Project Folder Structure

Run these commands to create a clean, project-oriented file layout:

```bash
mkdir -p ~/Projects/npi-knowledge-graph/docker/data
mkdir -p ~/Projects/npi-knowledge-graph/docker/logs
mkdir -p ~/Projects/npi-knowledge-graph/docker/plugins
mkdir -p ~/Projects/npi-knowledge-graph/data
mkdir -p ~/Projects/npi-knowledge-graph/cypher
mkdir -p ~/Projects/npi-knowledge-graph/python
```

This creates a self-contained environment for your knowledge graph work.

---

## 2. Pull the Neo4j ARM64 Image

```bash
docker pull neo4j:5
```

Docker automatically pulls the correct ARM64 build for the DGX machine.

---

## 3. Run the Neo4j Container

Navigate to the docker folder (optional but tidy):

```bash
cd ~/Projects/npi-knowledge-graph/docker
```

Start the Neo4j service:

```bash
docker run \
  --name neo4j-npi \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/your_strong_password \
  -v ~/Projects/npi-knowledge-graph/docker/data:/data \
  -v ~/Projects/npi-knowledge-graph/docker/logs:/logs \
  -v ~/Projects/npi-knowledge-graph/docker/plugins:/plugins \
  -v ~/Projects/npi-knowledge-graph/data:/import \
  -d neo4j:5
```

**Important:** Replace `your_strong_password` with a secure password.

### Ports
- **7474** → Neo4j Browser (web UI)
- **7687** → Bolt protocol (Python, apps, drivers)

---

## 4. Verify Neo4j Is Running

```bash
docker ps
```

Expected: a container named `neo4j-npi` showing as "Up".

If needed:
```bash
docker stop neo4j-npi
docker start neo4j-npi
```

---

## 5. Access the Neo4j Browser

Open:

```
http://localhost:7474
```

Login using:

- Username: `neo4j`
- Password: whatever you set in `NEO4J_AUTH`

Neo4j will prompt you to reset your password on the first login.

Test query:

```cypher
RETURN "Ninja's NPI Knowledge Graph is Alive!" AS status;
```

---

## 6. Next Steps

You now have Neo4j installed and running!  
Upcoming tasks:
- If you have an existing SQL database, try exporting a few tables or a small subset of rows as CSV.
- Think about how your data forms connections: people, places, events, codes, relationships, or time-based sequences.
- Load a simple CSV into Neo4j using `LOAD CSV` and experiment with creating nodes and relationships.
- Try writing basic Cypher queries using `MATCH`, `MERGE`, and simple graph patterns.
- Explore how graph queries can make certain analytical questions easier than multi-join SQL queries.

This setup gives you a foundation to explore knowledge graphs, visualize relationships, and experiment with graph‑based models in any domain you are curious about.

---