# Film schema and CSV preprocessing

The schema divides movie records into entity tables (`Film`, `Actors`, `Authors`, `Directors`, `Film_Studio`, `Genre_Type`) and junction tables recording the many-to-many relationships. Constraints include primary keys, foreign keys, nonnegative numeric checks, and an enumerated content rating condition.

| File | Purpose |
| --- | --- |
| [`create.sql`](create.sql) | Table definitions and constraints |
| [`ex1.py`](ex1.py) | Reads `oscars.csv` from `oscars.zip` and emits relation-specific CSV files |
| [`drop.sql`](drop.sql) | Removes the tables (destructive) |

The preprocessing script uses Python's standard-library `csv` and `zipfile` modules. It reads the original denormalized fields, parses multi-valued columns, and writes separate CSV files for each entity and relationship.

The input archive is not included. Run `ex1.py` in this directory with `oscars.zip` available locally. The generated CSV files are ignored by Git.

The SQL targets PostgreSQL syntax. Data loading into PostgreSQL is a separate step; the script produces CSV files but does not connect to a database itself.
