# Digital ocean setup

```bash=
sudo adduser ark
sudo usermod -aG sudo ark

# login as ark user
sudo su - ark
```

# Git
```bash=
sudo apt-get install -y git curl apt-transport-https update-notifier
```

# Node.Js
```bash=
sudo wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
(echo "deb https://deb.nodesource.com/node_11.x $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/nodesource.list)
sudo apt-get update
sudo apt-get install nodejs -y
```

# Package managers

```bash=
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
(echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list)
sudo apt-get update
sudo apt-get install -y yarn
```

# Dependencies

```bash=
sudo apt-get install build-essential libcairo2-dev pkg-config libtool autoconf automake python libpq-dev jq -y
```

# Database

```bash=
sudo apt-get install postgresql postgresql-contrib -y
sudo -i -u postgres psql -c "CREATE USER ark  WITH PASSWORD 'password' CREATEDB;"
sudo -i -u postgres psql -c "CREATE DATABASE ark_testnet WITH OWNER ark;"
```

---

# TESTING IF IT WORKS

```bash=
git clone https://github.com/arkecosystem/core
cd core
yarn setup
```


# Run all together in one setup script

### STEP1: Create ARK User
First create user ARK with default password `password`. This will make it easier for us to work with default settings.

```bash=
sudo adduser ark
```

### STEP2: Add ARK User To `sudoers`

Add user to `sudoers` and login under `ark` user:
```bash=
sudo usermod -aG sudo ark

# login as ark user
sudo su - ark
```


### STEP3:

Copy and past the following content to a script file and execute the script under `ark` user. This will install the following:

- dev devepdencies
- node js
- yarn package manager
- git 
- postgress


```bash=
#!/usr/bin/env bash
sudo apt-get install -y git curl apt-transport-https update-notifier

sudo wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
(echo "deb https://deb.nodesource.com/node_11.x $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/nodesource.list)
sudo apt-get update
sudo apt-get install nodejs -y


curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
(echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list)
sudo apt-get update
sudo apt-get install -y yarn

sudo apt-get install build-essential libcairo2-dev pkg-config libtool autoconf automake python libpq-dev jq -y

sudo apt-get install postgresql postgresql-contrib -y
sudo -i -u postgres psql -c "CREATE USER ark  WITH PASSWORD 'password' CREATEDB;"
sudo -i -u postgres psql -c "CREATE DATABASE ark_testnet WITH OWNER ark;"
```

### STEP4: Checkout CORE repository and try running testnet

Checkout core from our repository:

```bash=
git clone https://github.com/arkecosystem/core
git checkout develop

cd core
yarn setup
```


Run local testnet:

```bash=
cd core/packages/core

yarn full:testnet
```

