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

## Wait for apt-get lock before installing packages

```yml
# https://github.com/ansible/ansible/issues/51663#issuecomment-752286191
# A common issue, particularly during early boot or at specific clock times
# is that apt will be locked by another process, perhaps trying to autoupdate
# or just a race condition on a thread. This work-around (which can also be
# applied to any of the above statements) ensures that if there is a lock file
# engaged, which is trapped by the `msg` value, triggers a repeat until the
# lock file is released.
- name: Install OS dependencies
  apt:
    name: "{{ consul_os_packages }}"
    state: present
  register: apt_action
  retries: 100
  until: apt_action is success or ('Failed to lock apt for exclusive operation' not in apt_action.msg and '/var/lib/dpkg/lock' not in apt_action.msg)

```

## Donwload and run a project from an external source

The following playbook downloads a GitHub release, templates a config file and starts a systemd-service
```yml
  - name: Register working directory
    set_fact:
      http_script_bin_dir: "/home/{{ansible_ssh_user}}/services/http-script-executor"
      http_script_config_dir: /etc/http-script-executor

  - name: Create project directory
    ansible.builtin.file:
      path: "{{http_script_bin_dir}}"
      state: directory
      mode: '0755'
      owner: "{{ansible_ssh_user}}"
      group: "{{ansible_ssh_user}}"

  - name: Create config directory
    ansible.builtin.file:
      path: "{{http_script_config_dir}}"
      state: directory
      mode: '0755'
      owner: "{{ansible_ssh_user}}"
      group: "{{ansible_ssh_user}}"

  - name: Download latest release
    get_url:
      url: "https://github.com/iamd3vil/http-script-executor/releases/download/v0.1.0/http-script-executor_0.1.0_Linux_x86_64.tar.gz"
      dest: "{{http_script_bin_dir}}/http-script-executor.tar.xz"
      force: yes
      owner: "{{ansible_ssh_user}}"
      group: "{{ansible_ssh_user}}"

  - name: Unarchive the binary
    ansible.builtin.unarchive:
      src: "{{http_script_bin_dir}}/http-script-executor.tar.xz"
      dest: "{{http_script_bin_dir}}"
      remote_src: yes
      owner: "{{ansible_ssh_user}}"
      group: "{{ansible_ssh_user}}"

  - name: Copy config file.
    template:
      src: ./templates/http_script_executor/config.toml.j2
      dest: "{{http_script_config_dir}}/config.toml"
      owner: "{{ansible_ssh_user}}"
      group: "{{ansible_ssh_user}}"
    register: output

  - name: Copy binary to PATH
    ansible.builtin.copy:
      src: "{{http_script_bin_dir}}/http-script-executor"
      dest: "/usr/local/bin/http-script-executor"
      remote_src: yes
      owner: "{{ansible_ssh_user}}"
      group: "{{ansible_ssh_user}}"
      mode: +x
    register: output


  - name: Cleanup project folder
    file:
      state: absent
      path: "{{http_script_bin_dir}}"

  - name: Add systemd script for program
    template:
      src: ./templates/http_script_executor/http-script-executor.service.j2
      dest: "/etc/systemd/system/http-script-executor.service"
      owner: root
      group: root
      mode: 0644
    register: systemd_unit

  - name: Reload systemd
    systemd:
      daemon_reload: true
    when: systemd_unit is changed

  - name: Start service
    service:
      name: http-script-executor
      state: started
      enabled: yes

  - name: Restart service
    service:
      name: http-script-executor
      state: restarted
    when: output.changed
```

### Systemd example

```
[Unit]
Description= A simple HTTP server which executes scripts
After=network.target

[Service]
ExecStart=/usr/local/bin/http-script-executor --config=/etc/http-script-executor/config.toml
User={{ansible_ssh_user}}
Group={{ansible_ssh_user}}

[Install]
WantedBy=multi-user.target
```