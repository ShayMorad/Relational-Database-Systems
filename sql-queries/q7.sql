select country, count(institution) as institutionCount
from institutions
group by country
order by country asc;
