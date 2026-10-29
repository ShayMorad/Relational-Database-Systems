with YoungConferences as (
    select conference
    from authors
    group by conference
    having count(distinct year) <= 15),

AuthorsInYoungConferences as (
    select distinct name
    from authors
    where conference in (select conference from YoungConferences)),

AllAuthors as (
    select distinct name
    from authors),

AuthorsOnlyInYoungConferences as (
    select name
    from AllAuthors
    except
    select name
    from authors
    where conference not in (select conference from YoungConferences))

select name
from AuthorsOnlyInYoungConferences
order by name asc;