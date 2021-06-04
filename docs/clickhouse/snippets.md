# Clickhouse Snippets

## Check Table Size

```sql
SELECT
    concat(database, '.', table) AS table,
    formatReadableSize(sum(bytes)) AS size,
    sum(bytes) AS bytes_size,
    sum(rows) AS rows,
    max(modification_time) AS latest_modification,
    any(engine) AS engine
FROM system.parts
WHERE active
GROUP BY
    database,
    table
ORDER BY bytes_size DESC
```

## Access Management

```sql
SHOW CREATE USER
SHOW ACCESS
```

## Listing

```sql
SHOW TABLES
SHOW CREATE TABLE
SHOW DATABASES
```
