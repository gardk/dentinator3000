.param set :f1 0.0125
.param set :f2 0.717
.param set :prec 4

.headers off
.mode list

.output probe0.csv
SELECT
    group_concat(printf('%.*f',
        :prec,
        cast(rf1t AS real) * :f1 * :f2 -
        cast(sf1t AS real) * :f1 * :f2
    ))
FROM
    samples_with_reference
WHERE
    probe = 0
GROUP BY
    run
ORDER BY
    sample ASC;

.output probe1.csv
SELECT
    group_concat(printf('%.*f',
        :prec,
        cast(rf1t AS real) * :f1 * :f2 -
        cast(sf1t AS real) * :f1 * :f2
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

