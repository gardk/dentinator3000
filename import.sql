.read schema.sql

DELETE FROM raw_samples;
DELETE FROM raw_reference;

.import --csv input.csv raw_samples
.import --csv reference.csv raw_reference

