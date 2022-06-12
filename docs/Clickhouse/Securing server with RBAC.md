Clickhouse offers a wide variety of [managing](https://clickhouse.tech/docs/en/operations/access-rights/) access control using RBAC. As mentioned in the docs, Clickhouse offers two ways to manage users, roles, policies etc:

- SQL driven approach
- Using configuration files like `users.xml`

The docs mention SQL driven approach is more recommended.

Clickhouse comes with a `default` user which _unfortunately_ is widely permissive. It is attached to a default profile, which allows access to entire DB:

```sql
CREATE USER default IDENTIFIED WITH plaintext_password SETTINGS PROFILE default
GRANT ALL ON *.* TO default WITH GRANT OPTION
```

Here's a **checklist** to follow in case you want to secure your Clickhouse installation.

**TL;DR**:

- [x] Enable access-management for `default` user.
- [x] Create a new admin user with SHA-256 password.
    * [x] Restrict to local network interface.
- [x] Revoke permissions or remove the `default` user.

### 1. Restrict the `default` user to connect only via local network interface.

The default configuration allows the `default` user to connect from **any** IP. This is dangerous since Clickhouse also offers an HTTP API (running on port 8123) by default). If there's no `token`/`basic_auth` passed in the HTTP request to this API, the `default` user is picked up. So, this means if you don't revoke permissions from `default` user, anyone who can access Clickhouse API _has_ access to entire DB.

To fix this, edit `/etc/clickhouse-server/users.xml`:

```xml
<networks>
    <ip>::/0</ip>
</networks>
```

And make it:

```xml
<networks>
  <ip>::1</ip>
  <ip>127.0.0.1</ip>
</networks>
```

### 2. Create an Admin user

```
CREATE USER IF NOT EXISTS admin IDENTIFIED WITH SHA256_PASSWORD BY '{{ADMIN_PASSWORD}}' HOST LOCAL;
GRANT ALL ON *.* TO admin WITH GRANT OPTION;
```

This creates an `admin` user with and stores the SHA-256 hash of the password in `/var/lib/clickhouse/access`. It also additonally only allows connection from a local interface using `HOST LOCAL` directive.

### 3. Remove default user

You can safely remove the `default` user as it's not really required.

Edit `users.xml` and remove everything inside `<users><default>` block.


```xml
<users>
</users>
```

Clickhouse automatically picks up changes from this file, so you don't need to restart the server.

## Creating Additional Users

Follow the SQL driven approach to add more users. If the users have some common access policies, you can create a role with these policies and assign roles to the user.

The [offficial docs](https://clickhouse.tech/docs/en/operations/access-rights/) are really good to help you further.