#!/bin/bash
# -*- ENCODING: UTF-8 -*-
clear

myDirProject=$(basename `pwd`);
echo "................................................................. "
echo "................................................................. "
echo "................................................................. "
echo "                      Install MyDocker                            "
echo " ................................................................."
echo "................................................................. "
echo "................................................................. "
echo ""
echo "Checking ... "
echo ""

dataIst=0;
composeIst=0;
docIst=0;

if [ -d $myDirProject/data ];
then
  echo " - "$myDirProject"/data -> Installed"
  dataIst=1;
fi;

if [ -f /`pwd`/docker-compose.yml ];
then
  echo " - "$myDirProject"/docker-compose.yml -> Installed"
  composeIst=1;
fi;

if [ -f /`pwd`/doc.sh ];
then
  echo " - "$myDirProject"/doc.sh -> Installed"
  docIst=1;
fi;

if [ $dataIst = 0 ];
then
  cp -r `pwd`/vendor/elementsystems/docker-manager/tools/data /`pwd`/data
  if [ -d /`pwd`/data ];
  then
    echo " - "$myDirProject"/data -> Installed"
    dataIst=1;
  else
    echo -e "\e[0;31mERROR\e[0m: data folder not created"
  fi;

fi;


if [ $composeIst = 0 ];
then
  cp  `pwd`/vendor/elementsystems/docker-manager/tools/docker-compose.yml  `pwd`/docker-compose.yml
  if [ -f /`pwd`/docker-compose.yml ];
  then
    echo " - "$myDirProject"/docker-compose.yml -> Installed"
    composeIst=1;
  else
    echo -e "\e[0;31mERROR\e[0m: docker-compose.yml not created"
  fi;

fi;


if [ $docIst = 0 ];
then
  cp  `pwd`/vendor/elementsystems/docker-manager/tools/doc.sh `pwd`/doc.sh
  if [ -f /`pwd`/doc.sh ];
  then
    echo " - "$myDirProject"/doc.sh -> Installed"
    docIst=1;
  else
    echo -e "\e[0;31mERROR\e[0m: doc.sh not created"
  fi;

fi;

if  [ $docIst = 1 ] && [ $composeIst = 1 ] && [ $dataIst = 1 ] ;
then
  chmod -x `pwd`/vendor/elementsystems/docker-manager/myDocker.sh
  cp `pwd`/vendor/elementsystems/docker-manager/myDocker.sh `pwd`/myDocker.sh


  echo ""
  echo "Everything is already installed."
  echo ""
  echo "---------------------------------"
  echo -e "\e[0;33mRUN\e[0m: bash myDocker.sh"
  echo "---------------------------------"
  echo ""
  echo "Have a nice day. :D"
  echo ""
  echo ""

else
  echo "\e[0;31mThere was a problem during installation\e[0m  :( "
fi;
