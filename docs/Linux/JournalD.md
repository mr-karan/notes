## Debugging steps when journal logs are missing
Follow these debugging steps, when `systemd` service is running, but logs are missing in `journalctl`:

1.  `sudo -i` if not already.
2.  Try running `journalctl -b` to see messages from the current boot.
3.  If you still get `-- No entries --`, run `journalctl --verify`.
4.  If you get `No journal files were found`, something is corrupted with the journal service itself. Run `systemctl status systemd-journald*`
5.  If the services are all "green" (active/running), something is borked with the log files in `/var/log/journal/<hash>`. Try running the following to recreate them:

`systemctl restart systemd-journald.service`

https://unix.stackexchange.com/a/538881

In my case, I had a fresh droplet created on DO but `journal` entries were missing for all services. Doing a `sudo systemctl restart systemd-journald.service` fixed this weird as hell issue.