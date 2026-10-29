with AllAuthorsYearConferencesCount as (
    select name, year, SUM(totalcount) as stc
    from authors natural join conferences
    where institution = 'Hebrew University of Jerusalem' and area = 'ai'
    group by name, year
)
select year, name
from AllAuthorsYearConferencesCount A1
where stc >= all (
        Select stc
        from AllAuthorsYearConferencesCount A2
        where A2.year = A1.year
    )
    and year between 2000 and 2020
order by year, name;
