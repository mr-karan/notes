## Check Table Size

```sql
SELECT
    concat(database, '.', table) AS table,
    formatReadableSize(sum(bytes)) AS size,
    sum(rows) AS rows,
    max(modification_time) AS latest_modification,
    sum(bytes) AS bytes_size,
    any(engine) AS engine,
    formatReadableSize(sum(primary_key_bytes_in_memory)) AS primary_keys_size
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

## Show Mutations

### Pending

```sql
SELECT *
FROM system.mutations
WHERE is_done = 0
```

## Cardinality

```sql
SELECT
    formatReadableQuantity(uniq(URL)) AS cardinality_URL,
    formatReadableQuantity(uniq(UserID)) AS cardinality_UserID
FROM
(
    SELECT
        user_id AS UserID,
        http_uri AS URL
    FROM logs.http
)
```