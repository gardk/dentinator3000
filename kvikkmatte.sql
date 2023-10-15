.param set :f1 0.0125
.param set :f2 0.717
.param set :probe 1

.header off
.mode list
.separator ,
.output output.csv

select
    group_concat(
        cast(rvalue as real) * :f1 * :f2 -
        cast(svalue as real) * :f1 * :f2
    )
from
    samples_with_reference
where
    probe = :probe
group by
    line
order by
    sample asc;

.output

