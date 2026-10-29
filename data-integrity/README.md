# Transaction consistency checks

[`contradictions.sql`](contradictions.sql) compares pairs of rows from `sales` and flags inconsistencies in attributes that should agree:

- The same transaction number is associated with conflicting dates or customers.
- The same product number appears with conflicting product names.
- The same customer number appears with conflicting countries.

It returns distinct transaction and product identifiers for suspicious rows. The checks depend on the assumptions of the original exercise's relational model; different datasets may have legitimate exceptions.

[`drop.sql`](drop.sql) deletes the `movies` and `sales` tables. It is retained as an exercise artifact and should only be used with a disposable database.
