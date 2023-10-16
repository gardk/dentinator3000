.param set :f1 0.0125
.param set :f2 1472
.param set :prec 4

.headers off
.mode list

.output output/probe0.csv
SELECT
    group_concat(printf('%.*f',
        :prec,
        cast(rf1t AS real) * :f1 * (cast(:f2 as real) * 1000 / 2000000) -
        cast(sf1t AS real) * :f1 * (cast(:f2 as real) * 1000 / 2000000)
    ))
FROM
    samples_with_reference
WHERE
    probe = 0
GROUP BY
    run
ORDER BY
    sample ASC;

.output output/probe1.csv
SELECT
    group_concat(printf('%.*f',
        :prec,
        cast(rf1t AS real) * :f1 * (cast(:f2 as real) * 1000 / 2000000) -
        cast(sf1t AS real) * :f1 * (cast(:f2 as real) * 1000 / 2000000)
    ))
FROM
    samples_with_reference
WHERE
    probe = 1
GROUP BY
    run
ORDER BY
    sample ASC;

.output

.headers on
.mode column

