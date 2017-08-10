#!/bin/bash
# -*- ENCODING: UTF-8 -*-


title() {
    clear
    myDirTitle=$(basename `pwd`);
    echo "  ____ _    ____ _  _ ____ _  _ ___    ____ _   _ ____ ___ ____ _  _ ____  "
    echo "  |___ |    |___ |\/| |___ |\ |  |     [__   \_/  [__   |  |___ |\/| [__   "
    echo "  |___ |___ |___ |  | |___ | \|  |     ___]   |   ___]  |  |___ |  | ___]  "
    echo "                                                                           "
    echo " ..............................myDOCKER...................................."
    echo -e "\e[0;33mProjekt\e[0m: \e[0;36m $myDirTitle\e[0m"
    echo -e "\e[0;33mUser\e[0m:    \e[0;36m $USER \e[0m"

}


checkUnsereDB(){
    title;

    UPDATE="update";
    MIS=$(docker ps  --format "{{.Names}}");
    myDir=$(basename `pwd`);
    myDir=${myDir,,};
    arrMIS=( $MIS );

    myDb='db';

    for i in "${arrMIS[@]}"; do

       if [[ $i =~ $myDir ]]; then


         if [[ $i =~ $myDb ]]; then
           nameContainer=$i
           backupData $nameContainer $UPDATE;
         fi;

        # Remove Container
        docker stop $i;
        docker rm  $i;
       fi;
     done
     echo "Bitte warten Sie einen Moment ..."
     title;
     echo -e "\e[1;31mContainers: $MIS sind UpDate\e[0m";




}


testOrigen(){



  myOriginLimpio=$myOrigin;
  my2="${myOriginLimpio/-/}"

  if [[ "$nameContainer" =~ "$my2" ]]; then
      echo "OK"
  else
      while true; do
      echo -e "\e[1;31mThis container is not of this project!\e[0m"
      echo -e "Inserts a project container \e[0;36m"$myOrigin"\e[0m or m for Menü ";
      read   nameContainer;
      case $nameContainer in
          [mM]* )   break;;
          * ) testOrigen $nameContainer $myOrigin; break;;
        esac
      done

  fi;
}



controlVar(){

  space=' ';
  if [[ "$nameContainer" =~ "$space" ]] ; then
    echo -e "\e[1;31mEs durft nicht spaces im  container namer zu schriben. \e[0m"
    read   nameContainer
    controlVar;
  fi;

}

hauptmenu(){
while true; do
    read -p "

    [1] Creation (run) container.
    [2] Start / Stoppen Conteiner.
    [3] Nur Start Container.
    [4] Remove Container.
    [5] Images.
    [0] Schließen
    " menuoption
    case $menuoption in
        [1]* ) optionsPorts; break;;
        [2]* ) title; containersAlles; break;;
        [3]* ) title;  containersStarter; break;;
        [4]* ) title;   eliminateContainer;  break;;
        [5]* ) title; seheImages; break;;
        [0]* ) echo "Bis später ..."; echo " " ; exit;;
        * ) title ;  echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " " ;;
    esac
done
}

menuImages(){
  while true; do
      read -p "

      [r] Remove Image.
      [m] Hauptmenü.
      [0] Schließen.
      " menuoption
      case $menuoption in
          [r]* ) read -p " ok Remove [IMAGE ID]... Welche? " nameImage; removeImage $nameImage; exit;;
          [m]* ) title; hauptmenu; break;;
          [0]* ) echo "Bis später ..."; echo " " ; exit;;
          * ) title ;  echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " ";docker images; ;;
      esac
  done
}



menuReturn(){

  while true; do
      read -p "
      [0] Schließen [m] Hauptmenü ...
      " menuOptionReturn
      case $menuOptionReturn in
          [mM]* ) title; hauptmenu; break;;
          [0]* ) echo "Schuss ... " ; exit;;
          * ) title ;  echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " " ;;
      esac
  done
}

menuStarten(){

  while true; do
      read -p "
      [0] Schließen. [m] Hauptmenü. [s] Starten. [x] Stoppen. [r] Remove Container.
      [t] Sehe Containers Schaffen/Starter. [f] Sehe Containers nur Starter.
      " menuOptionReturn
      case $menuOptionReturn in
          [mM]* ) title; hauptmenu; break;;
          [sS]* ) read -p " ok Strater ... Welche? " nameContainer; startContainer $nameContainer; exit;;
          [xX]* ) read -p " ok Stoppen ... Welche? " nameContainer; stopContainer $nameContainer; exit;;
          [tT]* ) title; containersAlles; break;;
          [fF]* ) title; containersStarter; break;;
          [rR]* ) title;   eliminateContainer;  break;;
          [0]* ) echo "Schuss ... " ; exit;;
          * ) title;
          echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " ";
          echo "Shaffen Containers ... ";
          echo " ";
          docker ps  --format "table {{.ID}}\t{{.Ports}}\t{{.Names}}" -a;
          echo  "Bitte wählen Sie eine richtige Option. ";echo " "; ;;
      esac
  done
}


menuPorts(){

  while true; do
      echo -e " PORT_DB : \e[1;33m$PORT_DB\e[0m"
      echo -e " PORT_PHPMYADMIN : \e[1;33m$PORT_PHPMYADMIN\e[0m"
      echo -e " PORT_PHP : \e[1;33m$PORT_PHP\e[0m"
      echo " "
      read -p  "Ist das richtig?
      [j] Ja. [n] Nein, Noch mal.
      [m] Gehe nach Hauptmenü und  bau nicht die container. [j], [n] oder [m]... "   menuoption;
      case $menuoption in
          [jJ]* ) checkUnsereDB; runDocker; break;;
          [nN]* ) optionsPorts; break;;
          [mM]* ) title; hauptmenu; break;;
          * ) title ;  echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " " ;;
      esac
  done

}


menuMemo(){

  while true; do
      echo -e " \e[1;33mAchtung!\e[0m"
      echo " "
      echo -e "\e[1;31mSie haben bereits einige Container aus diesem Projekt erstellt!
      Wenn du über die Container schreibst, geht Die Datenbank verloren\e[0m"
      read -p  "
      [j] Ok, ich will  Über das Schreiben.  [m] Nein, Gehe zu Hauptmenü.

        "   menuoption;
      case $menuoption in
          [jJ]* )  checkUnsereDB; runDocker;  break;;
          [mM]* ) title; hauptmenu; break;;
          * ) title ;  echo  -e "\e[1;35m Bitte wählen Sie eine richtige Option. \e[0m"; echo " "; echo " " ;;
      esac
  done

}
