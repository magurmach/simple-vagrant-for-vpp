#! /bin/bash
echo "Apt-get update"
sudo apt-get update
echo "Update done"

echo "Installing build-essential"
sudo apt-get -y -f install build-essential
echo "Installing build-essential done"

echo "Installing git-core"
sudo apt-get -y -f install git-core
echo "Installing git-core done"

echo "Installing libconfuse-dev"
sudo apt-get -y -f install libconfuse-dev
echo "Installing libconfuse-dev done"

echo "Installing gengetopt"
sudo apt-get -y -f install gengetopt
echo "Installing lgengetopt done"

echo "Installing libcap2-bin"
sudo apt-get -y -f install libcap2-bin
echo "Installing libcap2-bin done"

echo "Installing libzmq3-dev"
sudo apt-get -y -f install libzmq3-dev
echo "Installing libzmq3-dev done"

echo "Installing libxml2-dev"
sudo apt-get -y -f install libxml2-dev
echo "Installing libxml2-dev done"

echo "Installing htop..."
sudo apt-get -y -f install htop
echo "Installing htop done"

echo "Installing git..."
sudo apt-get -y -f install git
sudo apt-get -y -f install git-review
echo "Installing git done"

echo "Installing maven..."
sudo apt-get -y -f install maven
echo "Installing maven done"