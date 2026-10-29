select c1.cid as cid1, c2.cid as cid2
from Course c1 join Course c2 on c1.cid < c2.cid
where
    not exists (
        select preid
        from Prerequisites p1
        where p1.cid = c1.cid
        Except
        select preid
        from Prerequisites p2
        where p2.cid = c2.cid
    )
    and
    not exists (
        select preid
        from Prerequisites p2
        where p2.cid = c2.cid
        Except
        select preid
        from Prerequisites p1
        where p1.cid = c1.cid
    )
order by c1.cid, c2.cid;
