.headers off
.mode list

.output output/probe0_raw.csv
SELECT group_concat(f1t) FROM samples WHERE probe = 0 GROUP BY run ORDER BY sample ASC;

.output output/probe1_raw.csv
SELECT group_concat(f1t) FROM samples WHERE probe = 1 GROUP BY run ORDER BY sample ASC;

.output

.headers on
.mode column

