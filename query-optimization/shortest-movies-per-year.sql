WITH MinDurationPerYear AS (
    SELECT M1.movieId, M1.title, M1.duration, M1.year
    FROM Movies M1 JOIN ( 
		SELECT year, MIN(duration) AS min_duration
        FROM Movies
        GROUP BY year
    ) AS MinPerYear ON M1.year = MinPerYear.year AND M1.duration = MinPerYear.min_duration
)

SELECT DISTINCT movieId, title, duration
FROM MinDurationPerYear
ORDER BY movieId, title, duration;


