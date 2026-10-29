with mlExperts as (
    select A.name, count(distinct A.conference) as conferenceCount, max(A.year) as lastPublicationYear
    from authors A natural join conferences C
    where C.subarea = 'ml'
    group by A.name
    having count(distinct A.conference) >= 3),

currentMlExperts as (
    select name
    from mlExperts
    where lastPublicationYear >= 2020)

select name
from currentMlExperts
order by name;