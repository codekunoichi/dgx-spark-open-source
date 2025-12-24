## Local Setup Notes (Important: Python Version)

> ⚠️ **Important**  
> This project currently does **not** work with Python 3.14 due to upstream dependency constraints  
> (notably `neo4j-graphrag`).  
> Always use **Python 3.12** for local development.

The steps below document the exact setup that is known to work.

---

## Step-by-Step: Python 3.12 Virtual Environment Setup (macOS)

### 1. Verify Python 3.12 is installed
Using Homebrew:

```bash
brew list | grep python
```

You should see:
- `python@3.12`
- (Python 3.13 / 3.14 may also be installed — that is fine)

Confirm the binary:

```bash
python3.12 --version
```

---

### 2. Create a virtual environment using Python 3.12

From the repository root:

```bash
rm -rf venv
python3.12 -m venv venv
```

Activate the environment:

```bash
source venv/bin/activate
```

Verify the Python version **inside** the venv:

```bash
python --version
```

Expected output:
```
Python 3.12.x
```

---

### 3. Upgrade pip and install dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

If dependencies fail to install, double-check that:
- `python --version` reports **3.12**
- you are not using Python 3.14

---

### 4. Configure environment variables

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Update the Neo4j values for **local Neo4j Desktop**:

```env
NEO4J_URI=neo4j://127.0.0.1:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=<your-local-password>
NEO4J_DATABASE=neo4j
```

---

### 4a. Install APOC Plugin (Required for KG Builder)

You will find the code here [genai-graphrag-python](https://github.com/codekunoichi/genai-graphrag-python) 

> ⚠️ **Required for `kg_builder.py`**  
> The Knowledge Graph builder relies on APOC procedures (for example  
> `apoc.create.addLabels`) to dynamically assign labels during graph creation.
>  
> If APOC is not installed and enabled, `kg_builder.py` will fail at runtime.

#### Install APOC in Neo4j Desktop

1. Open **Neo4j Desktop**
2. Go to **Local instances**
3. Select your running DBMS (for example: `ninja-graph-experiments`)
4. Click the **three dots (⋯)** on the instance card → **Plugins**
5. Click **Install** next to **APOC**
6. Restart the DBMS

#### Verify APOC is available

Open the Neo4j Browser and run:

```cypher
SHOW PROCEDURES
YIELD name
WHERE name = "apoc.create.addLabels"
RETURN name;
```

If the procedure is returned, APOC is installed and enabled correctly.

Only proceed to running `kg_builder.py` after this verification succeeds.

---

### 5. Validate the environment

You will find the code here [genai-graphrag-python](https://github.com/codekunoichi/genai-graphrag-python) 

Run the test script:

```bash
python genai-graphrag-python/test_environment.py
```

Expected output:

```
Ran 5 tests in X.XXXs

OK
```

If all tests pass, the environment is correctly configured.

---

## Notes for Future Reference

- Do **not** use Python 3.14 for this repo
- Always recreate the venv with `python3.12` if you see dependency errors
- Neo4j Desktop runs locally on `neo4j://127.0.0.1:7687`
- Keep `.env` out of version control
