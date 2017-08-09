# DataBase

## was ist init.slq

init.sql ist unseren Dateinbank. Es ist ein SQL normal.

Nur mussen wir eien besondere line schriben.

In erste line mussen wir **--NAME_DATEINBANK** schriben.

Das ist wichtig, damit myDocker.sh  diese Datei brauche um die Dateibank zu kopieren

**Zu Beispiel**:

```
--midb3
CREATE DATABASE midb3;
USE midb3;

CREATE TABLE `names` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
 ....
 ....
```
