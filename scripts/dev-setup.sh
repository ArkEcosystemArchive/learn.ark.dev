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
sudo -i -u postgres psql -c "CREATE DATABASE ark_devnet WITH OWNER ark;"

# clone and yarn setup
git clone https://github.com/arkecosystem/core
cd core
git checkout develop

yarn setup 