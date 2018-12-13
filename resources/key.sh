#!/usr/bin/env bash

echo "Setup environment..."

KEY_PATH=$HOME/.ssh
KEY=vagrant@homestead
FILE="$KEY_PATH/$KEY"

mkdir -p $HOME/.ssh
sudo chmod 700 $HOME/.ssh
sudo chmod 600 $HOME/.ssh/$KEY
sudo chmod +r $HOME/.ssh/$KEY.pub
sudo chown -R ${whoami}:${whoami} $KEY_PATH

if [ -e "$FILE" ]; then
  echo "KEY already created. SKIP"
  #exit 1
else
  echo "Setup key..."
  echo #
  ssh-keygen -t rsa -N "" -f $KEY
  sudo mv vagrant@* $KEY_PATH
  sudo chmod 600 $KEY_PATH/$KEY
  sudo chmod +r $KEY_PATH/$KEY.pub
  sudo chown -R ${whoami}:${whoami} $KEY_PATH
  echo "SSH KEY has been created successfully"
fi


