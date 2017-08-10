#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#title            :myDocker.sh
#description      :Container Docker builder
#auto             :Element Systems <info@elementsystems> www.elementsystems.de
#date             :20170809

clear
source `pwd`/vendor/elementsystems/docker-manager/dev_install/menus.sh

runDocker(){
  myDirProject=$(basename `pwd`);
  rm .env
  echo "PORT_DB="$PORT_DB >> .env
  echo "PORT_PHPMYADMIN="$PORT_PHPMYADMIN >> .env
  echo "PORT_PHP="$PORT_PHP >> .env
  title;
  echo " "
  echo -e "\e[36mNeu zugeordnete Ports ...\e[0m"
  echo " "
  docker-compose up -d;
  containersStarter;
}



optionsPorts() {
  title;

  PORT_DB="3307"
  PORT_PHPMYADMIN="8100"
  PORT_PHP="8050"

  echo " Bitte, Geben Sie den PORT für DataBase [default: 3307] : "
  read PORT_DB_2
  echo "Bitte, Geben Sie den PORT für PHPmyAdmin [default: 8100] : "
  read PORT_PHPMYADMIN_2
  echo "Bitte, Geben Sie den PORT für Server-PHP [default: 8050] : "
  read PORT_PHP_2

  if [  -n "$PORT_DB_2"   ];
      then PORT_DB=$PORT_DB_2;
  fi;

  if [ -n "$PORT_PHPMYADMIN_2" ];
      then PORT_PHPMYADMIN=$PORT_PHPMYADMIN_2;
  fi;

  if [ -n "$PORT_PHP_2" ];
    then PORT_PHP=$PORT_PHP_2;
  fi;
  re='^[0-9]+$';
  if [[ $PORT_DB =~ $re ]] && [[ $PORT_PHPMYADMIN =~ $re ]] && [[ $PORT_PHP =~ $re ]]; then  echo "ok..."; else
      title;
      optionsPorts;   fi
      menuPorts;

}


containersAlles(){
        echo " ";
        echo "Shaffen Containers ..."; echo " ";
        docker ps  --format "table {{.Ports}}\t{{.Names}}\t{{.Status}}" -a ;
        menuStarten;

}
containersStarter(){
          echo " ";
          echo "Starten Containers ... ";echo " ";
          docker ps  --format "table {{.Ports}}\t{{.Names}}"; echo " ";
          menuStarten;

}

startContainer(){

  docker start $nameContainer
  title;
  echo " "
  echo "Starten Containers ... "
  echo " "
  docker ps  --format "table {{.Ports}}\t{{.Names}}"
  menuStarten;

}




stopContainer(){
  clear;
  echo "  Bitte warten Sie einen Moment ... "
  docker stop $nameContainer

  title;
  echo " "
  echo "Starten Containers ..."
  echo " "
  docker ps  --format "table {{.Ports}}\t{{.Names}}"
  menuStarten;
}


backupData(){

      # get Name database
      NAMEBD=`head -n 1 ./data/init.sql`
      NAMEBD=${NAMEBD:2 }

      docker start $nameContainer;
      docker exec -d $nameContainer  bash -c "mkdir dumpSQL";
      docker exec -d $nameContainer  bash -c "chmod -R 777 dumpSQL";
      docker exec -d $nameContainer  bash -c "touch /dumpSQL/dump.sql";

      # backup dataBase
      ACCTION="mysqldump  -uroot -padmin --databases "$NAMEBD" > /dumpSQL/dump.sql";
      docker exec -i $nameContainer  bash -c "$ACCTION";
      docker cp $nameContainer:/dumpSQL/dump.sql ./data/backup

      NEUNAME=$(date +%Y-%m-%d-%H%M%S-)$USER"-"$NAMEBD;


      # rename File backup database
      mv ./data/backup/dump.sql ./data/backup/$NEUNAME.sql

      echo " ";
      echo -e "\e[36mErstellt Backup von $NAMEBD als ./data/backup/$NEUNAME.sql\e[0m";
      echo -e "\e[1;31mContainer $nameContainer gelöscht\e[0m";
      echo " ";



}


eliminateContainer(){
  title;
  myOrigin=$(basename `pwd`);
  echo " ";
  echo "Shaffen Containers ..."; echo " ";
  docker ps  --format "table {{.Ports}}\t{{.Names}}\t{{.Status}}" -a ;
  echo " ";
  echo -e "Der Container muss gestoppt werden. --->>>  \e[31mDiese Option ist IRREVERSIBEL !!!\e[0m"
  echo " ";
  echo -e "\e[1;31mWelche?..."

  read   nameContainer;
  echo -e "\e[0m"

  controlVar;

  testOrigen $nameContainer $myOrigin;

  myDb='db';
  if [[ "$nameContainer" =~ "$myDb" ]]; then

    backupData $nameContainer $UPDATE;

  fi;

  docker stop $nameContainer;
  docker rm $nameContainer;
  title;
  containersAlles;

  }

removeImage(){
 docker rmi $nameImage;
 title;
 echo " "
 echo -e "\e[1;31m $nameImage wurde eliminiert...\e[0m"
 echo " "
 hauptmenu;
}



seheImages(){
  title;
  echo " ";
  echo "IMAGES ...";
  echo " ";
  docker images;
  menuImages;
}


title;
hauptmenu;
