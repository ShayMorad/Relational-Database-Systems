# Shortest movies by release year

[`shortest-movies-per-year.sql`](shortest-movies-per-year.sql) uses a common table expression and an aggregate subquery to identify movies whose duration is the minimum for their release year.

1. Group `Movies` by year and compute `MIN(duration)`.
2. Join those values back to `Movies` to recover the corresponding records.
3. Return distinct movie IDs, titles, and durations in sorted order.

This is a query formulation exercise rather than a measured benchmark: the repository does not contain execution plans or timing data for this SQL statement. The `Movies` table is not supplied.
