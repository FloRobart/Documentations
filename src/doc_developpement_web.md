# Documentation complète pour le développement web

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>

## Règles

- "`Saisie utilisateur`"
- '`Elément cliquable/sélectionnable`'
- `Nom de fichier, dossier ou autre`
- <Élément à remplacer>

> lien, raccourci clavier et phrase de demande de saisie

```txt
commande, extrait code et extrait de fichier
```

<div class="page"></div>

## Table des matières

****

- [Documentation complète pour le développement web](#documentation-complète-pour-le-développement-web)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [PHP](#php)
    - [Installation de la dernière version de PHP - Linux](#installation-de-la-dernière-version-de-php---linux)
  - [Composer](#composer)
    - [Installation de Composer - Linux](#installation-de-composer---linux)
      - [Installation simple d'une version récente de Composer - Linux](#installation-simple-dune-version-récente-de-composer---linux)
      - [Installation de la dernière version stable de Composer - Linux](#installation-de-la-dernière-version-stable-de-composer---linux)
  - [Nodejs et NPM](#nodejs-et-npm)
    - [Installation de Nodejs - Linux](#installation-de-nodejs---linux)
    - [Installation de NPM - Linux](#installation-de-npm---linux)
  - [XAMPP](#xampp)
    - [Installation de XAMPP - Linux](#installation-de-xampp---linux)
    - [Configuration de XAMPP - Linux](#configuration-de-xampp---linux)
      - [Modifier la taille maximale des paquets](#modifier-la-taille-maximale-des-paquets)
    - [Utilisation de XAMPP](#utilisation-de-xampp)
    - [Erreur avec XAMPP](#erreur-avec-xampp)
      - [Erreur un autre serveur web est déjà en cours d'exécution](#erreur-un-autre-serveur-web-est-déjà-en-cours-dexécution)
  - [PHP MyAdmin](#php-myadmin)
    - [Installation de PHP MyAdmin - Linux](#installation-de-php-myadmin---linux)
    - [Mise en place de l'accès à phpmyadmin sur tout les appareils d'un réseau local](#mise-en-place-de-laccès-à-phpmyadmin-sur-tout-les-appareils-dun-réseau-local)
  - [Apache](#apache)
    - [Installation du serveur web Apache pour php - Linux](#installation-du-serveur-web-apache-pour-php---linux)
  - [Base de données](#base-de-données)
    - [MySQL](#mysql)
      - [Installation de MySQL - Linux](#installation-de-mysql---linux)
      - [Configuration de MySQL - Linux](#configuration-de-mysql---linux)
    - [PosgreSQL](#posgresql)
      - [Installation de PostgreSQL - Linux](#installation-de-postgresql---linux)
      - [Configuration de Postgresql - Linux](#configuration-de-postgresql---linux)
  - [Framwork PHP](#framwork-php)
    - [Laravel](#laravel)
    - [Symfony](#symfony)
    - [CodeIgniter](#codeigniter)
  - [Licence](#licence)

<div class="page"></div>

## PHP

### Installation de la dernière version de PHP - Linux

- Installer php ainsi que toute ces dépendances et outils de développement depuis le dépot `apt` :

  ```bash
  sudo apt install php-common php-cli php-pgsql php-curl php-xml php-json php-dev php-intl php-pear
  ```

  - **php-common :** Fournit les fichiers communs pour la dernière version stable de PHP
  - **php-cli :** Fournit l'interface de ligne de commande pour PHP
  - **php-pgsql :** Fournit un module de support pour l'extension PostgreSQL de PHP
  - **php-curl :** Fournit un module de support pour l'extension CURL de PHP
  - **php-json :** Fournit un module de support pour l'extension JSON de PHP
  - **php-xml :** Fournit un module de support pour l'extension XML de PHP
  - **php-dev :** Fournit les fichiers de développement pour la dernière version stable de PHP
  - **php-intl :** Fournit un module de support pour l'extension INTL de PHP, permettant de lancer le serveur web spark fourni par CodeIgniter
  - **php-pear :** Fournit un gestionnaire de paquets pour PHP

  - Si l'extension `php-pgsql` ne fonctionne pas il peut être nécessaire de l'activer dans les fichiers de configuration '`/etc/php/<version>/cli/php.ini`' et '`/etc/php/<version>/apache2/php.ini`' :

    ```bash
    extension=php_pgsql.so
    ```

- Pour voir les autres paquets disponibles pour php :

  ```bash
  apt-cache search php
  ```

- Pour vérifier que php est bien installé avec la bonne version tapé la commande suivante dans un terminal :

  ```bash
  php -v
  ```

  - Sortie attendu de la commande :

    ```bash
    PHP 8.1.12-1ubuntu4.3 (cli) (built: Aug 17 2023 17:37:48) (NTS)
    Copyright (c) The PHP Group
    Zend Engine v4.1.12, Copyright (c) Zend Technologies
        with Zend OPcache v8.1.12-1ubuntu4.3, Copyright (c), by Zend Technologies
    ```

## Composer

### Installation de Composer - Linux

**Composer est un gestionnaire de dépendances PHP qui permet d'installer et de mettre à jour facilement des bibliothèques tierces ou des frameworks comme CodeIgniter, Laravel ou Symfony.**

À la date ou j'écris ce document (octobre 2023) la dernière version de `Composer` disponible est la version `2.6.5` et la dernière version disponible dans les dépots `apt` est la version `2.5.8`.

#### Installation simple d'une version récente de Composer - Linux

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install composer
  ```

#### Installation de la dernière version stable de Composer - Linux

- Vous pouvez trouver la documentation officielle de `Composer` à l'adresse suivante :
  ><https://getcomposer.org/download/>

- Placez vous dans le repertoire de votre choix, dans cas `/home/${USER}` :

  ```bash
  cd /home/${USER}
  ```

- Créer un fichier `InstallComposer.sh` :

  ```bash
  touch InstallComposer.sh
  ```

- Donnez les droits d'exécution au fichier `InstallComposer.sh` :

  ```bash
  chmod +x InstallComposer.sh
  ```

- Ouvrez le fichier `InstallComposer.sh` avec votre éditeur de texte favoris :

  ```bash
  open InstallComposer.sh
  ```

- Ajourter le code suivant dans le fichier `InstallComposer.sh` puis sauvegarder le :

  ```bash
  #!/bin/bash

  # Télécharge le fichier d'intalation de composer via le lien 'https://getcomposer.org/installer' et le place dans le fichier 'composer-setup.php'
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

  # Vérifie que le fichier 'composer-setup.php' est bien le bon
  php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installateur vérifié'; } else { echo 'Installateur corrompu'; unlink('composer-setup.php'); } echo PHP_EOL;"

  # Exécute le fichier d'installation 'composer-setup.php'
  php composer-setup.php

  # Efface le fichier d'installation 'composer-setup.php'
  php -r "unlink('composer-setup.php');"
  ```

  - Pour plus de détails
    - **php -r :** Exécute du code PHP depuis la ligne de commande
    - **copy :** Copie un fichier depuis un emplacement (même en ligne) vers un autre
    - **hash_file :** Calcule le hachage d'un fichier en utilisant l'algorithme de hachage choisi
    - **echo :** Affiche une chaîne de caractères
    - **unlink :** Efface un fichier
    - **PHP_EOL :** Constante de fin de ligne
    - **php composer-setup.php :** Exécute le fichier `composer-setup.php`
    - **unlink('composer-setup.php') :** Efface le fichier `composer-setup.php`

- Exécuter le fichier `InstallComposer.sh` :

  ```bash
  ./InstallComposer.sh
  ```

- Pour tout les utilisateurs (Besoin de droit d'administration)
  - Pour que tout les utilisateur profite de la commande '`composer`' dans le terminal déplacer le fichier `composer.phar` dans le fichier '`/usr/bin/composer`' :

    ```bash
    sudo mv composer.phar /usr/bin/composer
    ```

- Pour un utilisateur spécifique (Pas besoin de droit d'administration)
  - Pour que seul l'utilisateur courant profite de la commande '`composer`' dans le terminal déplacer le fichier `composer.phar` dans le fichier '`/home/${USER}/.local/bin/composer`' :

    ```bash
    mv composer.phar /home/${USER}/.local/bin/composer
    ```

- Créer un projet en utilisant CodeIgniter et Composer :

  ```bash
  composer create-project codeigniter4/appstarter <nameApp>
  ```

## Nodejs et NPM

- Sources :
  ><https://www.hostinger.fr/tutoriels/comment-installer-node-js-sur-ubuntu>

### Installation de Nodejs - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install nodejs
  ```

### Installation de NPM - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install npm
  ```

## XAMPP

- Source :
  ><https://linux.how2shout.com/how-to-start-xampp-in-ubuntu-using-the-command-line/>

### Installation de XAMPP - Linux

- Téléchargez la dernière version de XAMPP sur le site officiel :

  ><https://www.apachefriends.org/fr/index.html>

- Placez vous dans le répertoire de téléchargement, dans mon cas `/home/${USER}/Téléchargements` :

  ```shell
  cd /home/${USER}/Téléchargements
  ```

- Donnez les droits d'exécution au fichier téléchargé :

  ```shell
  chmod +x xampp-linux-x64-8.1.12-0-installer.run
  ```

- Exécutez le fichier téléchargé :

  ```shell
  ./xampp-linux-x64-8.1.12-0-installer.run
  ```

- Suivez les instructions de l'installeur
- Créez un icon sur le bureau pour XAMPP :

  ```shell
  echo "[Desktop Entry]
  Version=1.0
  Type=Application
  Name=XAMPP
  Exec=sudo /opt/lampp/manager-linux-x64.run
  Icon=/opt/lampp/htdocs/favicon.ico
  Terminal=false
  StartupNotify=false" > ~/Bureau/XAMPP.desktop
  ```

- Activations de la commande `xampp` et `xampp-gui` :
  - **Vous avez 2 solutions pour activer les commandes `xampp` et `xampp-gui`, sois vous créer des liens symboliques sois vous créez des alias.**
    - Créez des liens symboliques pour XAMPP et pour XAMPP GUI :

      ```shell
      sudo ln /opt/lampp/xampp /usr/local/bin/xampp
      sudo ln /opt/lampp/manager-linux-x64.run /usr/local/bin/xampp-gui
      ```

    - Créez une alias pour XAMPP et pour le GUI de XAMPP :

      ```shell
      echo "alias xampp='sudo /opt/lampp/xampp'" >> ~/.bashrc
      echo "alias xampp-gui='sudo /opt/lampp/manager-linux-x64.run'" >> ~/.bashrc
      ```

      - Rechargez le fichier `~/.bashrc` :

        ```shell
        source ~/.bashrc
        ```

  - (Optionnel) Personnellement j'ai mis toutes les alias ci-dessous pour XAMPP :

    ```shell
    alias xampp='sudo /opt/lampp/xampp'
    alias xampp-gui='sudo /opt/lampp/manager-linux-x64.run'
    alias xampp-start='xampp startapache && xampp startmysql'
    alias xampp-stop='xampp stopapache && xampp stopmysql'
    ```

### Configuration de XAMPP - Linux

#### Modifier la taille maximale des paquets

- Ouvrer le fichier de configuration de MySQL :

  - Avec un éditeur de texte

    ```shell
    sudo nano /opt/lampp/etc/my.cnf
    ```

  - Avec l'inteface graphique de XAMPP
    - Ouvrer l'inteface graphique de XAMPP :

      ```shell
      xampp-gui
      ```

    - Cliquer sur l'onglet `Manage Servers`
    - Cliquer sur `MySQL Database`
    - Cliquer sur le bouton `Configure`
    - Cliquer sur le bouton `Open Conf File` dans la fenêtre qui s'est ouverte à l'étape précédente
- Changer la valeur de `max_allowed_packet` pour remplacer `1M` par la taille maximale que vous voulez, par exemple `20M` pour 20 Mo :

  ```conf
  ...
  max_allowed_packet=20M
  ...
  ```

- Redémarrer le serveur MySQL :

  ```shell
  xampp restartmysql
  ```

- Penser également à modifier la taille maximale des fichiers dans le fichier de configuration de PHP :

  - Ouvrer le fichier de configuration de PHP :

    ```shell
    sudo nano /opt/lampp/etc/php.ini
    ```
  
  - Changer les valeurs de `post_max_size` et `upload_max_filesize` pour remplacer `8M` par la taille maximale que vous voulez, par exemple `20M` pour 20 Mo :

    ```conf
    ...
    post_max_size=20M
    ...
    upload_max_filesize=20M
    ...
    ```

  - Si vous avez des fichiers très volumineux à envoyer, pensez également à modifier la valeur de `max_execution_time` pour augmenter le temps d'exécution maximal d'un script PHP. Par exemple, pour 5 minutes au lieu de 30 secondes par defaut sur PHP 8.3 :

    ```conf
    ...
    max_execution_time=300
    ...
    ```

### Utilisation de XAMPP

**Si les commandes ne fonctionnent pas, regarder la section [Installation de XAMPP - Linux](#installation-de-xampp---linux) pour voir comment créer des alias pour XAMPP et le GUI de XAMPP.**

- Ouvrir le GUI de XAMPP :

  ```shell
  xampp-gui
  ```

- Afficher l'aide de XAMPP :

  ```shell
  xampp --help
  ```

### Erreur avec XAMPP

#### Erreur un autre serveur web est déjà en cours d'exécution

- Si vous avez l'erreur suivante :

  ```shell
  XAMPP:  Another web server is already running.
  ```

- Vous pouvez arrêter le serveur web Apache en utilisant la commande suivante :

  ```shell
  sudo /etc/init.d/apache2 stop
  ```

- Vous pouvez ensuite relancer XAMPP en utilisant la commande suivante :

  ```shell
  xampp startapache
  ```

## PHP MyAdmin

### Installation de PHP MyAdmin - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install phpmyadmin
  ```

### Mise en place de l'accès à phpmyadmin sur tout les appareils d'un réseau local

- Ouvrez le fichier `/opt/lampp/etc/extra/httpd-xampp.conf` avec un éditeur de texte en administrateur

  ```shell
  sudo open /opt/lampp/etc/extra/httpd-xampp.conf
  ```

- Remplacez la ligne "`Require local`" par "`Require all granted`" comment indiqué ci-dessous

  ```conf
  ...
  <Directory "/opt/lampp/phpmyadmin">
      AllowOverride AuthConfig Limit
      Require all granted
      ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var
  </Directory>
  ...
  ```

- Sauvegardez le fichier
- Rechargez le serveur Apache en utilisant l'inteface graphique de XAMPP ou grâce à la commande suivante :

  ```shell
  sudo xampp reloadapache
  ```

## Apache

**SI vous avez installé XAMPP, vous n'avez pas besoin d'installer Apache.**

### Installation du serveur web Apache pour php - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install libapache2-mod-php
  ```

- Voici quelque commande utile pour gérer le serveur web Apache :

  ```shell
  systemctl start apache2
  systemctl status apache2
  systemctl stop apache2
  ```

## Base de données

**SI vous avez installé XAMPP, vous n'avez pas besoin d'installer MySQL ou PostgreSQL.**

### MySQL

#### Installation de MySQL - Linux

#### Configuration de MySQL - Linux

### PosgreSQL

#### Installation de PostgreSQL - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install postgresql postgresql-contrib
  ```

#### Configuration de Postgresql - Linux

> <https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-20-04>

## Framwork PHP

### Laravel

[Documentation Laravel](./doc_laravel.md)

### Symfony

[Documentation Symfony](./doc_symfony.md)

### CodeIgniter

[Documentation CodeIgniter](./doc_codeigniter.md)

## Licence

doc_developpement_web.md

Copyright (C) 2024 Floris Robart

Authors: Floris Robart

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program; if not, write to the Free Software Foundation,
Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
