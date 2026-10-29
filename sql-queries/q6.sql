select distinct A1.name
from authors a1
where not exists(
    select *
    from (
        select conference, year
        from authors
        where name = 'Omri Abend'
    ) omriC
    where not exists(
        select *
        from authors A2
        where A2.conference = omriC.conference 
        and A2.year = omriC.year
        and A2.name = A1.name
    )
)
order by a1.name asc;
