.read schema.sql

DELETE FROM raw_samples;
DELETE FROM raw_reference;

.import --csv input.csv raw_samples
.import --csv reference.csv raw_reference

INSERT INTO samples SELECT * FROM (
    WITH intermediate1 AS (
        SELECT
            sample,
            probe != lag(probe, 1, probe) OVER (ORDER BY sample ASC) AS neq,
            probe,
            f1t
        FROM
            raw_samples
    ), intermediate2 AS (
        SELECT
            sample,
            sum(neq) OVER (ROWS UNBOUNDED PRECEDING) AS run,
            probe,
            f1t
        FROM
            intermediate1
    )
    SELECT
        sample,
        run,
        row_number() OVER (PARTITION BY run, probe ORDER BY sample ASC) AS seq,
        probe,
        f1t
    FROM
        intermediate2
);
INSERT INTO reference
SELECT
    row_number() OVER () AS seq,
    f1t
FROM
    raw_reference;

