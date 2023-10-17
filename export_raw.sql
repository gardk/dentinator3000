.headers off
.mode list

.output output/probe0.csv
SELECT group_concat(f1t) FROM samples WHERE probe = 0 GROUP BY run ORDER BY sample ASC;

.output output/probe1.csv
SELECT group_concat(f1t) FROM samples WHERE probe = 1 GROUP BY run ORDER BY sample ASC;

.output

.headers on
.mode column

