#!/usr/bin/env bash

echo "Setup environment..."

KEY_PATH=$HOME/.ssh
KEY=vagrant@homestead
FILE="$KEY_PATH/$KEY"

if [[ -n "$1" ]]; then
    cp -i resources/Homestead.json Homestead.json
else
    cp -i resources/Homestead.yaml Homestead.yaml
fi

cp -i resources/after.sh after.sh
cp -i resources/aliases aliases


mkdir -p $HOME/.ssh
sudo chmod 700 $HOME/.ssh
sudo chmod 600 $HOME/.ssh/vagrant@homestead
sudo chmod +r $HOME/.ssh/*.pub
sudo chown -R ${whoami}:${whoami} $KEY_PATH

if [ -e "$FILE" ]; then
  echo "KEY already created. SKIP"
  #exit 1
else
  echo "Setup key..."
  echo #
  ssh-keygen -t rsa -N "" -f $KEY
  sudo mv $KEY $KEY_PATH
  sudo chmod 600 $KEY_PATH/$KEY
  sudo chmod +r $KEY_PATH/$KEY.pub
  sudo chown -R ${whoami}:${whoami} $KEY_PATH
fi

echo "SSH KEY has been created successfully"
echo #


echo "Homestead initialized!"
