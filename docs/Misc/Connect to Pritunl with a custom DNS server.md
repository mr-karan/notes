## Problem

I faced this issue when I disabled `systemd-resolved` on my system (Ubuntu 20.04) but Pritunl tried to update the DNS entry via `systemd-resolvd` and it failed when the service wasn't running.

```bash
sudo systemctl stop systemd-resolved         
sudo systemctl disable systemd-resolved 
```

Logs where it tried to look for the service:

```log
tail -f ~/.config/pritunl/profiles/*
<14>Mar 10 23:54:25 a65e97e8075b8b500c5e9cfe29083e4d-up.sh: Link 'tun0' coming up
<14>Mar 10 23:54:25 a65e97e8075b8b500c5e9cfe29083e4d-up.sh: Adding IPv4 DNS Server 1.1.1.1
<14>Mar 10 23:54:25 a65e97e8075b8b500c5e9cfe29083e4d-up.sh: SetLinkDNS(30 1 2 4 1 1 1 1)
Call failed: Unit dbus-org.freedesktop.resolve1.service not found.
<8>Mar 10 23:54:25 a65e97e8075b8b500c5e9cfe29083e4d-up.sh: 'busctl' exited with status 1
Wed Mar 10 23:54:25 2021 WARNING: Failed running command (--up/--down): external program exited with error status: 1
Wed Mar 10 23:54:25 2021 Exiting due to fatal error
```

You can see it fails at the step `Call failed: Unit dbus-org.freedesktop.resolve1.service not found`. 

## Solution

- The solution is to disable `systemd-resolved` at the `NetworkManager` level. You need to add the following config block which overrides these settings at `/etc/NetworkManager/NetworkManager.conf`:

```ini
[main]
...
dns=default
systemd-resolved=false
...
```

- Restart `network-manager`:

```bash
sudo systemctl restart NetworkManager
```

Now, when you try to connect to Pritunl, it will work fine :)


