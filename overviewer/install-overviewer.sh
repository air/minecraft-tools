#!/bin/bash

# Install the latest version of Overviewer.

# add repository
sudo apt-add-repository 'deb http://overviewer.org/debian ./'
wget -O - http://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -

# install overviewer
sudo apt-get update
sudo apt-get install -y minecraft-overviewer
