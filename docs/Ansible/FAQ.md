## Tags

Tags are **opt-in**. If you've an Ansible Playbook, the task will always run. To ensure it only runs if a tag is given and **never** otherwise, use the `never` tag.

```
- never
- my_custom_tag
```

If a task is defined with above tags, then only if `my_custom_tag` is there, the task will run.

To make this simple, the playbook run command should have a list of tags that are to be executed. `--tags='abc,def'` is the way to supply these tags on the command-line.

!!! tip
    Use Makefiles whenever possible.

If you add a tag to a playbook, then the tag is **appended** to the role.

```
  roles:
    - name: clickhouse
	  tags: [check_me_out]
```

You can see this `check_me_out` tag is appended to each task in the role.

```
ansible-playbook -i inventory playbook.yml --list-tasks

playbook: playbook.yml

  play #1 (clickhouse): clickhouse      TAGS: []
    tasks:
      clickhouse : Install multiple packages    TAGS: [check_me_out, clickhouse_install]
      clickhouse : Add the APT Key for ClickHouse.      TAGS: [check_me_out, clickhouse_install]
      clickhouse : Add ClickHouse APT sources   TAGS: [check_me_out, clickhouse_install]
      clickhouse : Install ClickHouse   TAGS: [check_me_out, clickhouse_install]
      clickhouse : Config | Set ClickHouse configuration file   TAGS: [check_me_out, clickhouse_configure]
      clickhouse : Config | Set users configuration file        TAGS: [check_me_out, clickhouse_configure]
```

Hence, the best way is to have a `Makefile` with different tags supplied on the CLI:

```Makefile
install-clickhouse:
	ansible-playbook -i inventory playbook.yml --tags "clickhouse_install"

configure-clickhouse:
	ansible-playbook -i inventory playbook.yml --tags "clickhouse_configure"
```

### Naming Strategy

Since Ansible Tags [use](https://stackoverflow.com/a/30058874) `OR` (and not `AND`) as the joining condition, it becomes tricky to have a role with tasks like:

```
- clickhouse
- install

- clickhouse
- configure
```

In a case where you want to only run `configure`, you `just` have to pass `configure`. If you pass `clickhouse,configure`, even the `install.yml` will be run. This is important to note as it can cause issues when running playbooks.

The workaround then is to have a tag called `clickhouse_configure` and `clickhouse_install` and only pass that.

It's possible to preview the list of tasks which will be executed with:

```
ansible-playbook example.yml --tags "configuration,packages" --list-tasks
```

## Roles

!!! tip
    Always ensure you fetch the remote roles _again_ if you made any changes to them.

## Inventory

### Aliases

Aliases are helpful in cases where the `ansible_host` is same (bastion host), but the target host is defined with `ansible_ssh_extra_args`. In such cases, Ansible is unable to differentiate between two hostnames and it thinks both the hosts are same.

```ini
bastion-host ansible_ssh_port=22 ansible_ssh_user=ubuntu ansible_ssh_extra_args="-o 'Hostname 1.1.1.1'"
bastion-host ansible_ssh_port=22 ansible_ssh_user=ubuntu ansible_ssh_extra_args="-o 'Hostname 2.2.2.2'"
```

The fix to this is to use an [`Inventory Alias`](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#inventory-aliases).

```ini
app_1 ansible_host=bastion-host ansible_ssh_port=22 ansible_ssh_user=ubuntu ansible_ssh_extra_args="-o 'Hostname 1.1.1.1'"
app_2 ansible_host=bastion-host ansible_ssh_port=22 ansible_ssh_user=ubuntu ansible_ssh_extra_args="-o 'Hostname 2.2.2.2'"
```

So with the alias `app_1` and `app_2`, Ansible is able to differentiate b/w two hostnames.
