# Common Usecases

## Assert a list of variables

```yml
---
- name: assert if all template variables are present
  assert:
    that:
      - "{{item}} is defined"
      - "{{item}} | length > 0"
    quiet: false
  with_items:
    - my_var
    - another_var
  no_log: true
```

## Execute a task before executing a role

```yml
- hosts: "my_server"
  become: yes
  # Assert if variables are present.
  pre_tasks:
    - import_tasks: ../tasks/assert.yml
  roles:
    - role: nginx
```
