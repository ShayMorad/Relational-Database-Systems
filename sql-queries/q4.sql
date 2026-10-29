select distinct A1.name ,A1.year
from authors A1 natural join conferences C1 natural join institutions I
where I.institution = 'Hebrew University of Jerusalem'
and C1.subarea = 'ai'
and Exists(
    select *
    from authors A2 natural join conferences C2
    where A2.name = A1.name
    and A2.year = A1.year
    and C2.subarea = 'economics')
order by A1.name, A1.year;
