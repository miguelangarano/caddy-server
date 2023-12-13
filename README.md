# Caddy server setup

This project allows you to setup with just one script a Caddy server in a Ubuntu machine.


# Pre requisites

- An Ubuntu server machine with git


# Setup

1. Execute `cd /home`
2. Execute `git clone https://github.com/miguelangarano/caddy-server.git`
3. Execute `cd caddy-server`
4. Execute `sudo su`
5. Execute `chmod +x initial-setup.sh`
6. Execute `./initial-setup.sh`


# Usage

You can edit the `Caddyfile` config but you must executue `docker-compose down` and then `docker-compose up -d`

Here's an example for the Caddyfile setup

```
test.google.com {
    reverse_proxy app:3000 {
      flush_interval -1
    }
}
```
