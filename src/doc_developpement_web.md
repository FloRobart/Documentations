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
  - [XAMPP](#xampp)
    - [Installation de XAMPP - Linux](#installation-de-xampp---linux)
    - [Utilisation de XAMPP](#utilisation-de-xampp)
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

- Créez une alias pour XAMPP et pour le GUI de XAMPP :

  ```shell
  echo "alias xampp='sudo /opt/lampp/xampp'" >> ~/.bashrc
  echo "alias xampp-gui='sudo /opt/lampp/manager-linux-x64.run'" >> ~/.bashrc
  ```

- Rechargez le fichier `~/.bashrc` :

  ```shell
  source ~/.bashrc
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
  <Directory "/opt/lampp/phpmyadmin">
      AllowOverride AuthConfig Limit
      Require all granted
      ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var
  </Directory>
  ```

- Sauvegardez le fichier
- Rechargez le serveur Apache en utilisant l'inteface graphique de XAMPP ou grâce à la commande suivante :

  ```shell
  systemctl restart apache2
  ```

## Apache

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

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
