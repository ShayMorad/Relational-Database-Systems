with country_institution_counts as (
    select I.country, A.institution, SUM(A.totalcount) as totalCountSum
    from authors A natural join institutions I
    group by I.country, A.institution),

max_counts as (
    select country, MAX(totalcountsum) as max_count
    from country_institution_counts
    group by country
)

select C.country, C.institution, C.totalCountSum as countryCount
from country_institution_counts C natural join max_counts M
where C.totalcountsum = M.max_count
order by C.country, C.institution;