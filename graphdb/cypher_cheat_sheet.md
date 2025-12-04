# Cypher Cheat Sheet — Essential Patterns for Neo4j
*A practical reference compiled from Ninja’s learning journey through Neo4j Fundamentals.*

## Overview
This cheat sheet captures the **core Cypher patterns** used in real graph modeling workflows — CREATE, MATCH, MERGE, SET, DELETE, relationships, timestamps, constraints, and more.  
It includes examples from the Neo4j course plus additional patterns essential for future graph AI + healthcare knowledge graph projects.

[Neo4j Public Profile](https://graphacademy.neo4j.com/u/7d1a842c-d173-413f-8c42-ea63792f10d0/)
---

# 1. Creating Nodes

### **CREATE**
Creates a new node every time (duplicates allowed).

```cypher
CREATE (p:Person {name: 'Tom Hanks'})
RETURN p;
```

---

# 2. Matching Existing Nodes

```cypher
MATCH (p:Person)
WHERE p.name = 'Tom Hanks'
RETURN p;
```

---

# 3. Updating Properties

```cypher
MATCH (p:Person {name: 'Tom Hanks'})
SET p.born = 1960
RETURN p;
```

---

# 4. MERGE (Find or Create)

```cypher
MERGE (p:Person {name: 'Tom Hanks'})
RETURN p;
```

---

# 5. Creating & Merging Relationships

```cypher
MERGE (p:Person {name: 'Tom Hanks'})
MERGE (m:Movie  {title: 'Cloud Atlas'})
MERGE (p)-[:ACTED_IN {role:'Cloud'}]->(m)
RETURN p, m;
```

---

# 6. MERGE with Timestamps (Creation vs Update)

```cypher
MERGE (p:Person {name:'Daniel Craig'})
ON CREATE SET p.createdAt = datetime()
ON MATCH  SET p.updatedAt = datetime()
RETURN p;
```

---

# 7. MERGE with Relationships + Timestamps

```cypher
MERGE (p:Person {name:'Daniel Craig'})
MERGE (m:Movie  {title:'Casino Royale'})
MERGE (p)-[:ACTED_IN {role:'James Bond'}]->(m)
ON CREATE SET p.createdAt = datetime()
ON MATCH  SET p.updatedAt = datetime()
RETURN p, m;
```

---

# 8. Deleting Nodes & Relationships

```cypher
MATCH (p:Person {name:'Daniel Craig'})
DELETE p;
```
You may get error if relationship to the Daniel Craig node still exists, use the following to cascade delete.

```cypher
MATCH (p:Person {name:'Daniel Craig'})
DETACH DELETE p;
```

---

# 9. Returning Nodes and Relationships

```cypher
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)
RETURN p, r, m;
```

---

# 10. Merging Multiple Properties

```cypher
MATCH (p:Person {name:'Tom Hanks'})
SET p += {
  born: 1956,
  country: 'USA',
  updatedAt: datetime()
}
RETURN p;
```

---

# 11. Indexes & Constraints

```cypher
CREATE INDEX person_name_index
FOR (p:Person) ON (p.name);
```

```cypher
CREATE CONSTRAINT person_name_unique
FOR (p:Person) REQUIRE p.name IS UNIQUE;
```

---

# 12. Removing Properties

```cypher
MATCH (p:Person {name:'Tom Hanks'})
REMOVE p.country
RETURN p;
```

---

# 13. Deleting Only Relationships

```cypher
MATCH (:Person {name:'Tom Hanks'})-[r:ACTED_IN]->(:Movie)
DELETE r;
```

---

# 14. Counting Nodes & Relationships

```cypher
MATCH (p:Person)
RETURN count(p) AS numPeople;
```

```cypher
MATCH (:Person)-[r:ACTED_IN]->(:Movie)
RETURN count(r) AS numRoles;
```

---

# 15. Mini Healthcare Example

```cypher
MERGE (p:Patient {id:'P123'})
MERGE (prov:Provider {npi:'1234567890'})
MERGE (e:Encounter {enc_id:'E987', date:date('2024-03-01')})
MERGE (p)-[:HAD_ENCOUNTER]->(e)
MERGE (e)-[:SEEN_BY]->(prov)
RETURN p, e, prov;
```

---

# Summary Table

| Task | Cypher Pattern | Notes |
|------|----------------|-------|
| Create node | `CREATE (n:Label {...})` | Always creates |
| Match node | `MATCH (n:Label)` | Read only |
| Update | `SET n.prop = ...` | Add/overwrite |
| Merge | `MERGE (n:Label {...})` | Find or create |
| Merge w/timestamps | `MERGE … ON CREATE SET … ON MATCH SET …` | Tracks creation/update |
| Delete | `DELETE n` | Fails if rels exist |
| Detach delete | `DETACH DELETE n` | Removes node + rels |
| Create relationship | `MERGE (a)-[:TYPE]->(b)` | Prevents duplicates |
| Index | `CREATE INDEX …` | Speeds queries |
| Unique | `CREATE CONSTRAINT … UNIQUE` | Prevents duplicates |

---

*Prepared for Ninja’s Neo4j Knowledge Graph Journey.*
