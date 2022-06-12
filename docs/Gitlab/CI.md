## SSH to a server
- Create a public/private key pair on the remote instance
- Copy the `private key` as an env variable in Gitlab CI
- Use the following snippet to SSH:
```yml
stages:
  - prepare
  - deploy

default:
  image:
    name: public.ecr.aws/ubuntu/ubuntu:20.04

.ssh-commands: &ssh-commands
  - apt-get -y update && apt-get install -y rsync
  - 'which ssh-agent || ( apt-get install -y openssh-client )'
  - eval $(ssh-agent -s)
  - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
  - mkdir -p ~/.ssh
  - chmod 700 ~/.ssh

sync-deploy-scripts:
  before_script:
    - *ssh-commands
  stage: deploy
  script:
    - rsync --cvs-exclude -ravz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" ./ ubuntu@<remote_ip>:/home/ubuntu/app
  only:
    - main

```