select distinct A.name
from authors A natural join conferences C
where C.area = 'theory'
  and A.year < 1980
  and not exists (
    select *
    from authors A2 natural join conferences C2
    where A2.name = A.name
      and (C2.area <> 'theory' or A2.year >= 1980)
)
order by A.name asc;
