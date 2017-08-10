#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#title            :install.sh
#description      :Installer for myDocker.sh
#auto             :Element Systems <info@elementsystems> www.elementsystems.de
#date             :20170809




overwrite(){

  echo ""
  echo "Overwriting ..."
  echo ""

  chmod -x `pwd`/vendor/elementsystems/docker-manager/myDocker.sh
  cp `pwd`/vendor/elementsystems/docker-manager/myDocker.sh `pwd`/myDocker.sh
  echo "myDocker.sh -> Overwriting."
  cp  `pwd`/vendor/elementsystems/docker-manager/tools/doc.sh `pwd`/doc.sh
  echo "doc.sh -> Overwriting."

  rm -r `pwd`/data
  cp -r `pwd`/vendor/elementsystems/docker-manager/tools/data `pwd`/data
  echo "data Ordener -> Overwriting."

  allIStOk;

}

installHead(){
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
  echo -e "Projekt: \e[0;36m"$myDirProject"\e[0m"
  echo ""
}


check(){
      dataIst=0;
      composeIst=0;
      docIst=0;
      echo ""
      echo "Checking ..."
      echo ""
      if [ -d data ];
      then
        echo " - "$myDirProject"/data -> Exists"
        dataIst=1;
      fi;

      if [ -f /`pwd`/docker-compose.yml ];
      then
        echo " - "$myDirProject"/docker-compose.yml -> Exists"
        composeIst=1;
      fi;

      if [ -f /`pwd`/doc.sh ];
      then
        echo " - "$myDirProject"/doc.sh -> Exists"
        docIst=1;
      fi;

      if [ $dataIst = 0 ];
      then
        cp -r `pwd`/vendor/elementsystems/docker-manager/tools/data `pwd`/data
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


        allIStOk;

      else
        echo "\e[0;31mThere was a problem during installation\e[0m  :( "
      fi;
}


allIStOk(){
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

}


installHead;
while true; do
    read -p "

    [1] Überschreiben [löschen alt und create Nue].
    [2] Check [Check und wenn wir eine datein ausbleiben, installiert es ihn. ].
    [0] Schließen
    " menuoption
    case $menuoption in
        [1]* ) installHead; overwrite; break;;
        [2]* ) installHead; check; break;;
        [0]* ) echo "Ok ... Schuussss ..."; echo " " ; exit;;
        * ) title ;  echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " " ;;
    esac
done
