# CSV Import Cheat Sheet for Neo4j  
These notes follow the flow and sequence of the Neo4j GraphAcademy course on **Importing CSV Data with Cypher**.  
Course Certificate: [Neo4j Academy – Certificate](https://graphacademy.neo4j.com/c/893955ee-797a-4c43-93e5-802861d082a0/)  
The following are my structured notes and working examples from the course.  

---

## 1. Basic: LOAD CSV Preview

Previewing rows without loading anything:

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/people.csv' AS row
RETURN row;
```

Counting rows:

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/people.csv' AS row
RETURN count(row);
```

---

## 2. Loading CSV & Creating/Updating Nodes

Creating Person nodes with properties from the CSV:

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/persons.csv' AS row
MERGE (p:Person {tmdbId: toInteger(row.person_tmdbId)})
SET
  p.imdbId = toInteger(row.person_imdbId),
  p.bornIn = row.bornIn,
  p.name = row.name,
  p.bio = row.bio,
  p.poster = row.poster,
  p.url = row.url,
  p.born = row.born,
  p.died = row.died;
```

Spot-check:

```cypher
MATCH (p:Person) RETURN p LIMIT 25;
```

---

## 3. Constraints (Uniqueness & Performance)

Creating a uniqueness constraint:

```cypher
CREATE CONSTRAINT Person_tmdbId
FOR (x:Person)
REQUIRE x.tmdbId IS UNIQUE;
```

Checking constraints:

```cypher
SHOW CONSTRAINTS;
```

Dropping constraints:

```cypher
DROP CONSTRAINT Person_tmdbId;
```

---

## 4. Importing Movie Nodes

Load movies:

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/movies.csv' AS row
RETURN row;
```

Set movie properties:

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/movies.csv' AS row
MERGE (m:Movie {tmdbId: toInteger(row.movie_tmdbId)})
SET
  m.imdbId = toInteger(row.movie_tmdbId),
  m.released = row.released,
  m.title = row.title,
  m.year = row.year,
  m.plot = row.plot,
  m.budget = row.budget;
```

Movie constraint:

```cypher
CREATE CONSTRAINT Movie_tmdbId
FOR (m:Movie)
REQUIRE m.tmdbId IS UNIQUE;
```

Check:

```cypher
MATCH (m:Movie) RETURN m LIMIT 25;
```

---

## 5. Creating Relationships from CSV

### ACTED_IN Relationship

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/acted_in.csv' AS row
MATCH (p:Person {tmdbId: toInteger(row.person_tmdbId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (p)-[r:ACTED_IN]->(m)
SET r.role = row.role;
```

### DIRECTED Relationship

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/directed.csv' AS row
MATCH (p:Person {tmdbId: toInteger(row.person_tmdbId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (p)-[r:DIRECTED]->(m);
```

Check relationship data:

```cypher
MATCH (p:Person)-[r:DIRECTED]->(m:Movie)
RETURN p, r, m LIMIT 25;
```

Query for people who acted AND directed the same movie:

```cypher
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(p)
RETURN p, m;
```

---

## 6. Inspecting Property Types

```cypher
CALL apoc.meta.nodeTypeProperties()
YIELD nodeType, propertyName, propertyTypes;
```

---

## 7. Transforming Data Types (date, int, float, arrays)

Convert strings to dates:

```cypher
p.born = date(row.born),
p.died = date(row.died)
```

Convert numeric types:

```cypher
m.year = toInteger(row.year),
m.imdbRating = toFloat(row.imdbRating)
```

Split pipe-delimited strings into arrays:

```cypher
m.countries = split(row.countries, '|');
```

Filter nodes by array membership:

```cypher
MATCH (m:Movie)
WHERE "France" IN m.countries
RETURN m;
```

---

## 8. Creating Labels After Import

Example: Mark all Persons who acted as `:Actor`:

```cypher
MATCH (p:Person)-[:ACTED_IN]->()
WITH DISTINCT p SET p:Actor;
```

Similarly for Directors:

```cypher
MATCH (p:Person)-[:DIRECTED]->()
WITH DISTINCT p SET p:Director;
```

---

## 9. Full Import Workflow (Clean + Fresh Load)

Delete all nodes:

```cypher
MATCH (p:Person) DETACH DELETE p;
MATCH (m:Movie) DETACH DELETE m;
```

Drop constraints:

```cypher
DROP CONSTRAINT Person_tmdbId IF EXISTS;
DROP CONSTRAINT Movie_movieId IF EXISTS;
```

Recreate constraints:

```cypher
CREATE CONSTRAINT Person_tmdbId IF NOT EXISTS
FOR (x:Person)
REQUIRE x.tmdbId IS UNIQUE;

CREATE CONSTRAINT Movie_movieId IF NOT EXISTS
FOR (x:Movie)
REQUIRE x.movieId IS UNIQUE;
```

### Full Person Import

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/persons.csv' AS row
MERGE (p:Person {tmdbId: toInteger(row.person_tmdbId)})
SET
  p.imdbId = toInteger(row.person_imdbId),
  p.bornIn = row.bornIn,
  p.name = row.name,
  p.bio = row.bio,
  p.poster = row.poster,
  p.url = row.url,
  p.born = date(row.born),
  p.died = date(row.died);
```

### Full Movie Import

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/movies.csv' AS row
MERGE (m:Movie {movieId: toInteger(row.movieId)})
SET
  m.tmdbId = toInteger(row.movie_tmdbId),
  m.imdbId = toInteger(row.movie_imdbId),
  m.released = date(row.released),
  m.title = row.title,
  m.year = toInteger(row.year),
  m.plot = row.plot,
  m.budget = toInteger(row.budget),
  m.imdbRating = toFloat(row.imdbRating),
  m.poster = row.poster,
  m.runtime = toInteger(row.runtime),
  m.imdbVotes = toInteger(row.imdbVotes),
  m.revenue = toInteger(row.revenue),
  m.url = row.url,
  m.countries = split(row.countries, '|'),
  m.languages = split(row.languages, '|');
```

### Import Relationships

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/acted_in.csv' AS row
MATCH (p:Person {tmdbId: toInteger(row.person_tmdbId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (p)-[r:ACTED_IN]->(m)
SET r.role = row.role;

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/directed.csv' AS row
MATCH (p:Person {tmdbId: toInteger(row.person_tmdbId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (p)-[r:DIRECTED]->(m);
```

---

## 10. Transactional Loading (auto-chunked)

```cypher
:auto
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/persons.csv' AS row
CALL (row) {
    MERGE (p:Person {tmdbId: toInteger(row.person_tmdbId)})
    SET
      p.imdbId = toInteger(row.person_imdbId),
      p.bornIn = row.bornIn,
      p.name = row.name,
      p.bio = row.bio,
      p.poster = row.poster,
      p.url = row.url,
      p.born = date(row.born),
      p.died = date(row.died)
} IN TRANSACTIONS;
```

---

## 11. Example: Creating Multiple Nodes & Relationships from One CSV

```cypher
LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.
```
## 12. Additional Notes
LOAD CSV works for smll CSV files
When doing huge loads consider using one of the following
- Neo4J Data Importer
- neo4j-admin
- ETL tool like Apache Hop


## 13. Alltogether Script

````cypher
MATCH (p:Person) DETACH DELETE p;
MATCH (m:Movie) DETACH DELETE m;

DROP CONSTRAINT Person_tmdbId IF EXISTS;
DROP CONSTRAINT Movie_movieId IF EXISTS;

CREATE CONSTRAINT Person_tmdbId IF NOT EXISTS
FOR (x:Person)
REQUIRE x.tmdbId IS UNIQUE;

CREATE CONSTRAINT Movie_movieId IF NOT EXISTS
FOR (x:Movie)
REQUIRE x.movieId IS UNIQUE;

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/persons.csv' AS row
MERGE (p:Person {tmdbId: toInteger(row.person_tmdbId)})
SET
p.imdbId = toInteger(row.person_imdbId),
p.bornIn = row.bornIn,
p.name = row.name,
p.bio = row.bio,
p.poster = row.poster,
p.url = row.url,
p.born = date(row.born),
p.died = date(row.died);

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/movies.csv' AS row
MERGE (m:Movie {movieId: toInteger(row.movieId)})
SET
m.tmdbId = toInteger(row.movie_tmdbId),
m.imdbId = toInteger(row.movie_imdbId),
m.released = date(row.released),
m.title = row.title,
m.year = toInteger(row.year),
m.plot = row.plot,
m.budget = toInteger(row.budget),
m.imdbRating = toFloat(row.imdbRating),
m.poster = row.poster,
m.runtime = toInteger(row.runtime),
m.imdbVotes = toInteger(row.imdbVotes),
m.revenue = toInteger(row.revenue),
m.url = row.url,
m.countries = split(row.countries, '|'),
m.languages = split(row.languages, '|');

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/acted_in.csv' AS row
MATCH (p:Person {tmdbId: toInteger(row.person_tmdbId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (p)-[r:ACTED_IN]->(m)
SET r.role = row.role;

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/importing-cypher/directed.csv' AS row
MATCH (p:Person {tmdbId: toInteger(row.person_tmdbId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (p)-[r:DIRECTED]->(m);

MATCH (p:Person)-[:ACTED_IN]->()
WITH DISTINCT p SET p:Actor;

MATCH (p:Person)-[:DIRECTED]->()
WITH DISTINCT p SET p:Director;

````