select distinct A.institution, A.name
from authors A natural join institutions I
where I.region = 'africa'
order by A.institution, A.name;