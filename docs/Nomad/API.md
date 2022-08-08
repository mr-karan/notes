## List allocations

```
curl -vvvv --get http://localhost:4646/v1/allocations\?namespace\=\*
```

### Filter

By using `--filter` param, we can restrict the list of allocations with specific filter queries.

```
curl -vvvv --get http://localhost:4646/v1/allocations\?namespace\=\* \
    --data-urlencode 'filter=NodeID == "a7542cd4-491d-26c8-64d4-db4db979f61b"'
```