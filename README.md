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

## Install salt-master

Create a Separate Configuration File to specify where the salt files are located:

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

```java
sudo nano /srv/salt/base/test.sls
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

## Using a Virtual Environment as Root

Create a Virtual Environment:

Use venv to create a new virtual environment:

```java
apt install python3.12-venv

python3 -m venv /root/myenv
```

Activate the virtual environment:

```java
source /root/myenv/bin/activate
```

Install GitPython Within the Virtual Environment:

Once the virtual environment is activated, use pip to install GitPython:

```java
pip install GitPython
```

Use GitPython:

You can now use GitPython within this virtual environment.

Deactivate the Virtual Environment:

When you are done, you can deactivate the virtual environment:

```java
deactivate
```

# Using GitHub for Salt States

Edit Configuration:

```java
sudo nano /etc/salt/master
```

Update Configuration:

```java
gitfs_provider: gitpython

fileserver_backend:
  - roots
  - git

gitfs_remotes:
  - https://github.com/<your-username>/<your-repo>.git
```

Restart Salt Master:

```java
sudo systemctl restart salt-master
```

Update Fileserver Cache:

```java
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
