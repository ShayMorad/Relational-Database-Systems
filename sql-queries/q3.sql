select distinct A.institution, A.name
from authors A natural join institutions I
where I.country = 'il' 
and A.conference LIKE 'sig%'
and A.totalcount >= 2
order by A.institution, A.name;


