CREATE TABLE IF NOT EXISTS raw_samples (
    sample integer NOT NULL,
    cell integer NOT NULL,
    line integer NOT NULL,
    pf1s integer NOT NULL,
    pf2s integer NOT NULL,
    pf3s integer NOT NULL,
    pf4s integer NOT NULL,
    pf5s integer NOT NULL,
    pb1s integer NOT NULL,
    pb2s integer NOT NULL,
    pb3s integer NOT NULL,
    pb4s integer NOT NULL,
    pb5s integer NOT NULL,
    pb6s integer NOT NULL,
    pb7s integer NOT NULL,
    b1f1rs integer NOT NULL,
    b2f1rs integer NOT NULL,
    b3f1rs integer NOT NULL,
    b4f1rs integer NOT NULL,
    b5f1rs integer NOT NULL,
    b6f1rs integer NOT NULL,
    b7f1rs integer NOT NULL,
    b1f2rs integer NOT NULL,
    b2f2rs integer NOT NULL,
    b3f2rs integer NOT NULL,
    b4f2rs integer NOT NULL,
    b5f2rs integer NOT NULL,
    b6f2rs integer NOT NULL,
    b7f2rs integer NOT NULL,
    b1f3rs integer NOT NULL,
    b2f3rs integer NOT NULL,
    b3f3rs integer NOT NULL,
    b4f3rs integer NOT NULL,
    b5f3rs integer NOT NULL,
    b6f3rs integer NOT NULL,
    b7f3rs integer NOT NULL,
    b2b1rs integer NOT NULL,
    b3b1rs integer NOT NULL,
    b4b1rs integer NOT NULL,
    b5b1rs integer NOT NULL,
    b6b1rs integer NOT NULL,
    b7b1rs integer NOT NULL,
    f1f2t integer NOT NULL,
    b1b2t integer NOT NULL,
    f1b1t integer NOT NULL,
    min integer NOT NULL,
    f1t integer NOT NULL,
    b2b3t integer NOT NULL,
    max integer NOT NULL,
    b1b4tmean integer NOT NULL,
    auto integer NOT NULL,
    auto_chan integer NOT NULL,
    probe integer NOT NULL
) STRICT;

CREATE TABLE IF NOT EXISTS raw_reference (
    value integer NOT NULL
) STRICT;

CREATE VIEW IF NOT EXISTS samples AS
SELECT
    sample,
    probe,
    f1t AS value
FROM
    raw_samples
ORDER BY
    sample ASC;

CREATE VIEW IF NOT EXISTS samples_line AS
SELECT
    sample,
    row_number() OVER (ORDER BY sample ASC) -
    row_number() OVER (PARTITION BY probe ORDER BY sample ASC) AS line,
    probe,
    value
FROM
    samples
ORDER BY
    sample ASC;

CREATE VIEW IF NOT EXISTS samples_line_seq AS
SELECT
    sample,
    line,
    row_number() OVER (PARTITION BY line, probe ORDER BY sample ASC) as seq,
    probe,
    value
FROM
    samples_line
ORDER BY
    sample ASC;

CREATE VIEW IF NOT EXISTS reference AS
SELECT
    row_number() OVER () AS seq,
    value
FROM
    raw_reference;

CREATE VIEW IF NOT EXISTS samples_with_reference AS
SELECT
    sample,
    line,
    seq,
    probe,
    samples_line_seq.value AS svalue,
    reference.value AS rvalue
FROM
    samples_line_seq INNER JOIN reference USING (seq)
ORDER BY
    sample ASC;

