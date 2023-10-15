Flytt filen du vil prosessere inn i denne mappa med navnet `input.csv` og kjør følgende:

```
sqlite3 db

sqlite> .read import.sql
sqlite> .read export.sql
sqlite> .quit
```

Resultatet ligger nå i en fil som heter `output.csv`.

