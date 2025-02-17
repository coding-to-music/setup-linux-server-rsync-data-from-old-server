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


## File Permissions for SSH Keys
Private Key (id_rsa):

Permissions: 600 (read and write for the owner only)

```java
chmod 600 ~/.ssh/id_rsa
```

Public Key (id_rsa.pub):

Permissions: 644 (read and write for the owner, read-only for others)

```java
chmod 644 ~/.ssh/id_rsa.pub
```

## Add git to a new server and sign into GitHub

```java
sudo apt update
sudo apt install git

git config --global user.name "your_name"
git config --global user.email "your_email@example.com"

# test the connection to GitHub
ssh -T git@github.com
```



## Setup HashiCorp Vault to store secrets

## Install salt-master

## Install salt-minions

## accept keys so the master and minions see each other

list accepted keys

```java
sudo salt-key -L
```

remove keys from a minion

```java
sudo salt-key -d minion_name
```


## testing to ensure proper operation

When running Salt commands from the command line, you should use sudo to elevate your privileges. For example:

```java
sudo salt '*' test.ping
sudo salt '*' state.apply
```

Test Connectivity with Minions:

```java
sudo salt '*' test.ping
```

Apply a State File:

```java
sudo salt '*' state.apply setup_user
```

Run Arbitrary Commands:

```java
sudo salt '*' cmd.run 'echo Hello, World!'
```

## Using salt-master to perform tasks on the minions

### Create myuser on a new minion

define username and github account keys using Value

Create the user on the minion

```java
sudo salt '*' state.apply setup_user

# or

sudo salt 'dev-*' state.apply setup_user

# or

sudo salt 'server_name' state.apply setup_user
```


