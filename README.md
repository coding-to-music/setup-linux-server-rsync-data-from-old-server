# setup-linux-server-rsync-data-from-old-server

## 🚀 After creating a new cloud server, many items need to be installed and setup. Here they are... 🚀

https://github.com/coding-to-music/setup-linux-server-rsync-data-from-old-server

From / By

## Environment variables

```java

```

## GitHub

```java
git init
git add .
git remote remove origin
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:coding-to-music/setup-linux-server-rsync-data-from-old-server.git
git push -u origin main
```

## Overall task list

### Server basic setup

- [ ] set hostname
- [ ] set time zone to NYC
- [ ] remote mount a drive
- [ ] setup drive rsync

### Users

- [ ] install ssh keys
- [ ] disable root login
- [ ] create user for myself
- [ ] .bash_aliases for myself
- [ ] sudo for myself
- [ ] create user docker
- [ ] create user grafana

### cli Software

- [ ] github git
- [ ] gh github login
- [ ] vercel
- [ ] cloudflare

### systemctl processes

- [ ] node-exporter
- [ ] grafana alloy
- [ ] ufw firewall
- [ ] docker
- [ ] fail2ban

### environment software

- [ ] nvm
- [ ] node
- [ ] yarn
- [ ] pnpm
- [ ] deno
- [ ] pyenv
- [ ] python3

### databases & more

- [ ] postgresql
- [ ] supabase
- [ ] mongoDB
- [ ] influxDB
- [ ] kafka
- [ ] k3s

## Backup hard drive

- [ ] rsync

### Other related repos for setups and installation

https://github.com/coding-to-music/install-virtualbox-on-digitalocean-or-contabo


## Setup HashiCorp Vault to store secrets

## Install salt-master

## Install salt-minions

## accept keys so the master and minions see each other

## testing to ensure proper operation

## Using salt-master to perform tasks on the minions

### Create myuser on a new minion

define username and github account keys using Value

Create the user on the minion

```java
salt '*' state.apply setup_user

# or

salt 'dev-*' state.apply setup_user

# or

salt 'server_name' state.apply setup_user

```


