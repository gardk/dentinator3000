.header off
.mode list
.separator ,

.output output.csv
with samples_grouped as (
    select
        sample, probe, f1t,
        (
            row_number() over (order by sample) -
            row_number() over (partition by probe order by sample)
        ) as g
    from
        samples
)
select group_concat(f1t) as f1t from samples_grouped group by probe, g order by sample desc;

.mode column
.output

