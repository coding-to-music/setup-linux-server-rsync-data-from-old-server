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
- [ ] k3s or MicroK8s

## Backup hard drive

- [ ] rsync

### Other related repos for setups and installation

https://github.com/coding-to-music/install-virtualbox-on-digitalocean-or-contabo


# MicroK8s

https://microk8s.io/?_gl=1*vqfb35*_gcl_au*MTU0NjY4NTgwMi4xNzM5ODIyNTg0

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

## tar and compress (zip) files to back them up on another server

```java
tar -czvf project.tar.gz /home/source_user/project
```

## copy the tar file from one server to another

With `scp` securely transfer a tar file between two servers that share the same SSH keys

```java
scp project.tar.gz destination_user@destination_server:/home/destination_user/
```

Uncompress the files from the archive

```java
tar -xzvf archive_name.tar.gz
```

## Setup HashiCorp Vault to store secrets

```java
```

## Install salt-master and/or salt-minion

Ubuntu / Debian install

https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/linux-deb.html

```java
# Ensure keyrings dir exists
sudo mkdir -p /etc/apt/keyrings
# Download public key
sudo curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
# Create apt repo target configuration
sudo curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
```

Available Installs (only install what is needed, such as only the salt-minion)

```java
sudo apt-get install salt-master
sudo apt-get install salt-minion
sudo apt-get install salt-ssh
sudo apt-get install salt-syndic
sudo apt-get install salt-cloud
sudo apt-get install salt-api
```


In the minion Set the address of the Master 

```java
sudo nano /etc/salt/minion
```

```java
interface: <address of the master>
pidfile: /run/salt/minion.pid
```

If needed, Ensure the salt-minion can write to its log file

```java
sudo chmod -R 755 /var/log/salt/

sudo touch  /etc/salt/minion_id
sudo chown salt:salt /etc/salt/minion_id

sudo mkdir -p /etc/salt/pki
sudo chown -R salt:salt /etc/salt/pki

sudo mkdir -p /run/salt
sudo chown -R salt:salt /run/salt
sudo chmod -R 755 /run/salt

sudo chmod -R 755 /etc/salt/minion.d
sudo chown -R salt:salt /etc/salt/minion.d


# might need to add the address of the master into /etc/hosts
sudo nano /etc/hosts
<address of the master> salt
```

Enable and start the available salt services

```java
sudo systemctl enable salt-master && sudo systemctl start salt-master
sudo systemctl enable salt-minion && sudo systemctl start salt-minion
sudo systemctl enable salt-syndic && sudo systemctl start salt-syndic
sudo systemctl enable salt-api && sudo systemctl start salt-api
```

Check the status and logs

```java
sudo journalctl -u salt-minion.service -n 10

sudo journalctl -u salt-master.service -n 10

sudo systemctl status salt-minion
sudo systemctl status salt-master
```

### Create a Separate Configuration File to specify where the salt files are located:

```java
sudo nano /etc/salt/master.d/file_roots.conf
```

Add Custom Configuration:

```java
file_roots:
  base:
    - /srv/salt/base
  dev:
    - /srv/salt/dev

pillar_roots:
  base:
    - /srv/pillar/base
  dev:
    - /srv/pillar/dev
```

```java
sudo mkdir -p /srv/pillar/base
sudo mkdir -p /srv/pillar/dev
sudo chown -R root:root /srv/pillar
sudo chmod -R 755 /srv/pillar

sudo nano /srv/pillar/base/top.sls
```

```java
base:
  '*':
    - example_pillar
```

```java
sudo nano /srv/pillar/base/example_pillar.sls
```

```java
example_key: example_value
```

Restart the Salt Master:

```java
sudo systemctl restart salt-master
sudo systemctl restart salt-minion
sudo systemctl status salt-master
sudo systemctl status salt-minion
sudo salt-run fileserver.update

sudo salt '*' pillar.items
```

create a `/srv/salt/base` directory if needed

```java
sudo mkdir -p /srv/salt/base
```

```java
sudo nano /srv/salt/base/test.sls
```

with this content

```java
test_state:
  cmd.run:
    - name: echo "Salt is working!"
```

```java
sudo chown -R root:root /srv/salt
sudo chmod -R 755 /srv/salt

sudo salt '*' state.apply test
```


To see what SLS files Salt can access, you can use the salt-run command to list all the available states. Here’s how you can do it:

List Available States:

Run the salt-run command with the `fileserver.update` and `fileserver.file_list` options to refresh the fileserver cache and list all the available SLS files:

```java
sudo salt-run fileserver.update
sudo salt-run fileserver.file_list

sudo journalctl -u salt-master

sudo tail -f /var/log/salt/master

sudo journalctl -u salt-master -f

sudo tail -f /var/log/salt/minion

sudo journalctl -u salt-minion -f
```

Filter for SLS Files:

You can further filter the output to list only the SLS files:

```java
sudo salt-run fileserver.file_list | grep '.sls'
```

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

sudo salt '*' state.apply base
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

sudo salt '*' state.apply base

sudo salt '*' state.apply test
```

Print out the salt configuration values

```java
sudo salt-call --local config.get file_roots

```

Create symlink so the default location will be my file location

```java
sudo ln -s /path/to/saltstack-repo/your_state_file.sls /srv/salt/your_state_file.sls

sudo ln -s /path/to/saltstack-repo/dev /srv/salt/dev
sudo ln -s /path/to/saltstack-repo/base /srv/salt/base
sudo ln -s /path/to/saltstack-repo/staging /srv/salt/staging
sudo ln -s /path/to/saltstack-repo/production /srv/salt/production
```

Verify that the symlinks have been created correctly:

```java
ls -l /srv/salt
```

# Using GitHub for Salt States

Install needed software pip and pyenv and yarn

Install pip

```java
sudo apt update
sudo apt install python3-pip
```

validate

```java
pip3 --version
```

Output

```java
pip 24.0 from /usr/lib/python3/dist-packages/pip (python 3.12)
```

Install Yarn

```java
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update

sudo apt install yarn
```

validate

```java
yarn --version
```

Output

```java
1.22.22
```

### using non-gitfs for local salt files

```java
sudo nano /etc/salt/master
```

```java
user: salt

fileserver_backend:
  - roots

file_roots:
  base:
    - /home/tmc/ap/vol8_24_12/setup-linux-server-rsync-data-from-old-server/srv/salt
  dev:
    - /home/tmc/ap/vol8_24_12/setup-linux-server-rsync-data-from-old-server/srv/salt

pillar_roots:
  base:
    - /home/tmc/ap/vol8_24_12/setup-linux-server-rsync-data-from-old-server/srv/salt/pillar
```

# Using GitHub for Salt States

Edit Configuration:

```java
sudo nano /etc/salt/master
```

Update Configuration:

```java
user: salt

gitfs_provider: gitpython

fileserver_backend:
  - roots
  - git

gitfs_remotes:
  - https://github.com/coding-to-music/setup-linux-server-rsync-data-from-old-server.git

gitfs_root: srv/salt

ext_pillar:
  - git:
    - main https://github.com/coding-to-music/setup-linux-server-rsync-data-from-old-server.git:
        - root: srv/salt/pillar
```

Restart Salt Master:

```java
sudo systemctl restart salt-master

journalctl -xeu salt-master.service
```

Update Fileserver Cache:

```java
sudo rm -rf /var/cache/salt/master/gitfs/*
sudo salt-run fileserver.update
sudo salt-run fileserver.file_list
```

Apply a State from GitHub

Apply State:

Assuming your GitHub repo structure matches the expected state structure, you can now apply a state:

```java
sudo salt '*' state.apply <state-name>
sudo salt '*' state.apply test
```

sudo apt update
sudo apt install python3-git

python3 -m pip show GitPython

sudo salt-master --versions-report
sudo salt-master --versions-report | grep git


sudo /opt/salt/bin/pip install GitPython

## Set the time zone to New York City

sudo timedatectl set-timezone America/New_York


## Onedir

/opt/saltstack/salt/bin/python3.10 -m pip install --upgrade pip

-- see what is installed
salt-call pip.list

salt-pip install <package-name>
salt-pip install GitPython
salt-pip install gitdb

-- Could not find a version that satisfies the requirement python3-git  
salt-pip install python3-git
salt-pip install python3-pygit2

sudo nano /etc/salt/master

view lines that do not begin with # and are not blank lines
grep -v -e '^#' -e '^$' /etc/salt/master
grep -v -e '^#' -e '^$' /etc/salt/minion

sudo chown -R salt:salt /var/cache/salt/master/gitfs
sudo chmod -R 755 /var/cache/salt/master/gitfs

sudo journalctl -u salt-minion.service -n 10
sudo journalctl -u salt-master.service -n 10

sudo journalctl -xeu salt-minion.service
sudo journalctl -xeu salt-master.service

sudo systemctl restart salt-master
sudo systemctl restart salt-minion

sudo systemctl status salt-master
sudo systemctl status salt-minion

sudo rm -rf /var/cache/salt/master/gitfs/*
sudo salt-run fileserver.update
sudo salt '*' state.apply test

sudo salt '*' cmd.run 'hostname -I'
sudo salt '*' test.version
sudo salt '*' disk.usage
sudo salt '*' sys.doc
sudo salt '*' cmd.run 'ls -l /etc'
sudo salt '*' pkg.install vim
sudo salt '*' network.interfaces

sudo salt-run fileserver.update
sudo salt-run fileserver.file_list

sudo salt-run git_pillar.update
sudo salt-run git_pillar.file_list

sudo systemctl stop salt-master
sudo salt-master -l debug

Validate the /etc/salt/master is valid:

sudo apt-get install yamllint
sudo yamllint /etc/salt/master

sudo salt-call --local config.get file_roots

sudo rm -rf /var/cache/salt/*
sudo rm -rf /var/run/salt/*
sudo rm -rf /var/log/salt/*

sudo salt-call --local --config-dir=/etc/salt config.get file_roots

sudo chown -R salt:salt /var/cache/salt
sudo chmod -R 755 /var/cache/salt

sudo mkdir -p /var/cache/salt/master/jobs/db
sudo mkdir -p /var/cache/salt/master/file_lists/roots

sudo chown -R salt:salt /var/cache/salt/master

sudo chown -R salt:salt /var/cache/salt/master/file_lists/roots
sudo chmod -R 755 /var/cache/salt/master/file_lists/roots

sudo mkdir -p /var/cache/salt/master/file_lists/roots/.base.w
sudo mkdir -p /var/cache/salt/master/roots/mtime_map
sudo mkdir -p /var/cache/salt/master/jobs/4b

sudo chown -R salt:salt /var/cache/salt/master/roots/*
sudo chown -R salt:salt /var/cache/salt/master/jobs/*

### Use salt-key so the master and minion can communicate

```java
salt-key -F master
salt-key -f foo.domain.com
salt-key -L
salt-key -a
salt-key -A
```

If you change what master the minion should point to then you may need to remove the key and restart the minion

```java
rm /var/lib/salt/pki/minion/minion_master.pub
```

### Pin the salt-master and salt-minion to version 3006.*

```java
sudo nano /etc/apt/preferences.d/salt-pin-1001
```

```java
Package: salt-*
Pin: version 3006.*
Pin-Priority: 1001
```

```java
sudo nano /etc/apt/preferences.d/salt-common-pin-1001
```

```java
Package: salt-common
Pin: version 3006.9
Pin-Priority: 1001
```

```java
sudo apt-get update
sudo apt-get install salt-master salt-minion

sudo apt-get install salt-master=3006.* salt-minion=3006.*
```

```java
sudo apt-get install salt-common=3006.9
sudo apt-get install salt-master=3006.9
sudo apt-get install salt-minion=3006.9
sudo apt-get install salt-ssh=3006.9
sudo apt-get install salt-syndic=3006.9
sudo apt-get install salt-cloud=3006.9
sudo apt-get install salt-api=3006.9
```

```java
# Example commands for pinning a current package minor so that
# it is skipped during system-wide apt-get upgrade events

sudo apt-mark hold salt-master
sudo apt-mark hold salt-minion
sudo apt-mark hold salt-ssh
sudo apt-mark hold salt-syndic
sudo apt-mark hold salt-cloud
sudo apt-mark hold salt-api
```

Warning

Salt dependency conflicts

If going with a non-latest point release of a target major version, you may be required to install other salt packages in a pinned fashion. For example, to install salt-minion, a user will be required to install salt-common at the same version:

```java
sudo apt-get install salt-minion=3006.9 salt-doc=3006.9
```

```java
apt-cache madison salt-minion
```

```java
apt-cache madison salt-minion
salt-minion |     3007.1 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3007.0 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.9 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.8 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.7 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.6 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.5 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.4 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.3 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.2 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.1 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
salt-minion |     3006.0 | https://packages.broadcom.com/artifactory/saltproject-deb stable/main amd64 Packages
```

Remove existing versions

```java
sudo apt-get remove salt-master 
sudo apt-get remove salt-minion
sudo apt-get remove salt-ssh
sudo apt-get remove salt-cloud
sudo apt-get remove salt-syndic
sudo apt-get remove salt-api

sudo apt-get purge salt-master salt-minion

sudo apt-get autoremove

```

```java
sudo apt-get install salt-common=3006.9 salt-master=3006.9 salt-minion=3006.9
```

Update the hosts file to know that the master server is also called salt

```java
sudo nano /etc/hosts
```

```java
<master_ip_address> salt
```

