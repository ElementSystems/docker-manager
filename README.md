# docker-manager

Dieses ist eine kleine Anwendung für bau Docker containers.

## Installation


in composer.json ...
```
"require": {
       ....
       "elementsystems/docker-manager": "0.*"
       ...
   }
```
Dann schreiben Sie in ihnen CLI ...

**Windows**: Sie müssen die Docker-Konsole eingeben.

```
# bash vendor/elementsystems/docker-manager/install.sh
```
Der Installateur wird einen Standard-Docker-Komponisten erstellen. Dies hat den Namen **docker-compose.yml.base**, wenn wir es verwenden wollen, müssen wir die **.base** beseitigen.

Wir können das Standard-Docker-Compose verwenden oder ein bestimmtes konfigurieren. Sobald die Docker-komponiert konfiguriert sind, können wir sie an die Entwickler verteilen, damit sie ihre Container erstellen können.

Wenn die instalation fertig ist, können Sie myDocker.sh benutzen ...

```
# bash myDocker.sh
```

## Gebrauch Manager project

[Konfigurationsdetails Wiki](https://github.com/ElementSystems/docker-manager/wiki)

## Gebrauch entwickler

Dann legen Sie sich in das Projektverzeichnis ...


1. Schaffen der Container: (in Console) ```bash ./myDocker.sh```

    1.1. Build Container: Option 1- wählen die Ports.

    1.2. Start / Stop Containers: Option 2

    1.3. Siehe Starten Containers: Option 3

    1.4. Remove Containers: Option 4 (Remove und backup database)

    1.5. Schließen: Option 0


Das Regeln (Datenbanksicherheit)...


- Wir können nicht löshen Conteiners von anderen Projekt.

- Wenn wir Conteineres mit SQL direct mit Docker Comandos löschen, können wir die SQL datein verlieren.


## Backup sql

**myDocker.sh** macht  eine backup Datenbank. In **./data/backup** . Der Name der Backup wird automatisch mit folgender Struktur erstellt:

```Y-m-d-hms-NameUser-NameDB.sql```



## Was los, wenn man "run" schlägt?


![3 containers](https://github.com/ElementSystems/docker-prototyp/blob/master/dev_install/info.jpg)

#### Optionen

- Erstellung der Dokumentation: (in Console) ```./doc.sh```
- Test CodeQualität: (in Console) ```phpcs ./src```


### Erstellt Docker-Umgebung.


Jetzt haben wir 3 container: **php** (unsere Anwendung), **db** (DataBase) und **phpmyadmin**.


## Zugang zu Dienstleistungen.

**Anwendung**

*Port, der in der Installation ausgewählt wurde

```
Windows:

http://192.168.99.100:8050*

Linux:
http://0.0.0.0:8050*
```
***

**Phpmyadmin**

*Port, der in der Installation ausgewählt wurde

```
Windows:

http://192.168.99.100:8100*

Linux:
http://0.0.0.0:8100*
```

**Password Phpmyadmin**

User = root

Password = admin

***

**db**
```
CLI
```

**Password CLI mysql**

User = root

Password = admin





## Die werkzeug

Die werkzeug gebraucht in diesem Anwendung. Wir installieren druch  "Composer".

- **phpcpd** - Control über duplicate code.
- **phpunit** - Test unit.
- **phpdocumentor** -Documentation
- **phpcs** - Code Qualität




## Datenbanksicherheit

Das System sichert nun die Datenbank, immer.

Wenn Sie einen Container löschen. Oder wenn wir einen Run laufen und die Anwärter überschreiben.

Um zu erkennen, dass ein Container eine Datenbank enthält, muss der Service als **db** benannt werden, im Docker-Compose.



![image Datenbanksicherheit](https://github.com/ElementSystems/docker-prototyp/blob/master/dev_install/info2.jpg)

# Verzeichnisstruktur

- **command** - Dateien suport Jenkins.
- **data** - Basedate init for Dev.
    - **backup** - Backups von Dev, generate von myDocker.sh .
- **dev_install** - includes for myDocker.sh.
- **doc** - Dokumentation von PHPDocumentator.
- **reports** - Reports von Jenkins Test
- **src** - Code.
- **tests** - Dateien PHPunit.
- **vendor** - Vendor.
