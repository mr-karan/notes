In an event of a DB crash or an unclean shutdown (host node failure), sometimes Postgres cannot find a valid checkpoint to start. The logs look like:

```
2021-02-16 04:09:44.977 UTC [26] LOG:  database system was shut down at 2021-02-16 03:50:02 UTC
2021-02-16 04:09:44.978 UTC [26] LOG:  record with incorrect prev-link 1DF0000/7BB0000 at 0/D786C2B0
2021-02-16 04:09:44.978 UTC [26] LOG:  invalid primary checkpoint record
2021-02-16 04:09:44.978 UTC [26] PANIC:  could not locate a valid checkpoint record
2021-02-16 04:09:45.252 UTC [25] LOG:  startup process (PID 26) was terminated by signal 6: Aborted
2021-02-16 04:09:45.252 UTC [25] LOG:  aborting startup due to startup process failure
2021-02-16 04:09:45.254 UTC [25] LOG:  database system is shut down
```

The line to notice here is:

```
2021-02-16 04:09:44.978 UTC [26] PANIC:  could not locate a valid checkpoint record
```

In such a scenario, perform a WAL Log Reset with [`pg_resetwal`](https://www.postgresql.org/docs/10/app-pgresetwal.html):

Quoting from the docs:

> pg_resetwal clears the write-ahead log (WAL) and optionally resets some other control information stored in the pg_control file. This function is sometimes needed if these files have become corrupted. It should be used only as a last resort, when the server will not start due to such corruption.

```
$ su postgres
$ pg_resetwal /var/lib/postgresql/data
```

Postgres should initialise now. But as the docs clarify further:

> After running this command, it should be possible to start the server, but bear in mind that the database might contain inconsistent data due to partially-committed transactions. You should immediately dump your data, run initdb, and reload. After reload, check for inconsistencies and repair as needed.

