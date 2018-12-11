#!/bin/sh
APPPATH=/var/www/totem.sindria.org
CODEPOOL=/var/codepool/repo@sindria-totem
BRANCH=deploy
if [ "$2" = "branch" ]; then
  WITHTAG=2
else
  WITHTAG=1
fi
if [ -z "$1" ]; then
  if [ $WITHTAG = 1 ]; then
    echo -e "ERRORE\n Si prega di specificare un tag annotato" | cowsay -f tux
  else
    echo -e "ERRORE\n Si prega di specificare un branch" | cowsay -f tux
  fi
  exit 1
else
  BRANCH=$1
  if [ $WITHTAG = 1 ]; then
    echo -e "Preparazione al deploy del tag: $BRANCH" | cowsay -f tux
    cd $CODEPOOL && git fetch -q --all && git checkout -q $BRANCH && cd - > /dev/null 2>&1
  else
    echo -e "Preparazione al deploy del branch: $BRANCH" | cowsay -f tux
    cd $CODEPOOL && git fetch -q --all && git checkout -q $BRANCH && git pull && cd - > /dev/null 2>&1
  fi
fi
#exit 1
#cd $CODEPOOL && git fetch -q --all && git checkout -q $BRANCH && cd - > /dev/null 2>&1
sudo rsync -arpoivtgz --chown=www:www --exclude-from=/app/scripts/rsync_exclude.txt  $CODEPOOL/ $APPPATH/
#service varnish restart
service php-fpm restart
figlet Deploy completato!
exit 1