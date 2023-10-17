## Import

Importering av data krever at to filer eksisterer i denne mappa:
- `input.csv` som må være en rå "tam.peaks.csv" fil
- `reference.csv` som må inneholde én kolonne med referansedata

For å definere schema og importere dataene inn i SQLite:
```
.\sqlite3.exe db
sqlite> .read import.sql
```

## Eksport

Det er to former for eksport: rådata og diff. Hver av dem har en egen script fil:
- `export_raw.sql`
- `export_diff.sql`

`export_diff.sql` har parametere som kan endres på toppen av filen.

For å kjøre eksport er det samme prosess som med import, åpne først databasen hvis du ikke
allerede er inne:
```
.\sqlite3.exe db
```

Så kjør hver eksport fil:
```
sqlite> .read export_raw.sql
sqlite> .read export_diff.sql
```

Resultatene blir lagt i `output` mappa, som `probeX_raw.csv` og `probeX_diff.csv`.

