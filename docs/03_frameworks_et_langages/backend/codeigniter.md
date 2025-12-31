# Installation et configuration d'un environnement de développement pour CodeIngniter et Composer sur Ubuntu 23.10 Mantic Minotaur

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

- [Installation et configuration d'un environnement de développement pour CodeIngniter et Composer sur Ubuntu 23.10 Mantic Minotaur](#installation-et-configuration-dun-environnement-de-développement-pour-codeingniter-et-composer-sur-ubuntu-2310-mantic-minotaur)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [description](#description)
  - [Prérequis](#prérequis)
  - [Installation du serveur web Apache pour php](#installation-du-serveur-web-apache-pour-php)
  - [Installation de la dernière version PHP](#installation-de-la-dernière-version-php)
  - [Installation de wget](#installation-de-wget)
  - [Installation de Composer](#installation-de-composer)
    - [Installation simple d'une version récente de Composer](#installation-simple-dune-version-récente-de-composer)
    - [Installation de la dernière version de Composer](#installation-de-la-dernière-version-de-composer)
  - [Licence](#licence)

<div class="page"></div>

## description

- **CodeIgniter :** est un framework PHP rapide, léger et open source utilisé pour développer des applications Web. Il suit le modèle architectural modèle-vue-contrôleur (MVC), qui sépare la logique de l'application en trois composants interconnectés : le modèle, la vue et le contrôleur. Les applications développées à l'aide de CodeIgniter peuvent fonctionner sur n'importe quel serveur capable d'exécuter le langage de script PHP 5.6 ou supérieur. CodeIgniter étant un franmework il ne s'install pas globalement sur la machine comme le ferai un langage mais dans le projet que vous développer.
- **Composer :** est un gestionnaire de dépendances PHP qui permet d'installer et de mettre à jour facilement des bibliothèques tierces ou des frameworks comme CodeIgniter.

## Prérequis

- Disposez des droits d'administration sur votre machine si vous faite une installation global (pour tous les utilisateurs).
- Si vous l'installer pour un utilisateur spécifique vous n'avez pas besoin de droit d'administration.

## Installation du serveur web Apache pour php

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install libapache2-mod-php
  ```

- Voici quelque commande utile pour gérer le serveur web Apache :

  ```bash
  systemctl start apache2
  systemctl status apache2
  systemctl stop apache2
  ```

## Installation de la dernière version PHP

- Installer php ainsi que toute ces dépendances et outils de développement depuis le dépot `apt` :

  ```bash
  sudo apt install php-common php-cli php-pgsql php-curl php-xml php-json
  ```

  - **php-common :** Fournit les fichiers communs pour la dernière version stable de PHP
  - **php-cli :** Fournit l'interface de ligne de commande pour PHP
  - **php-pgsql :** Fournit un module de support pour l'extension PostgreSQL de PHP
  - **php-curl :** Fournit un module de support pour l'extension CURL de PHP
  - **php-json :** Fournit un module de support pour l'extension JSON de PHP
  - **php-xml :** Fournit un module de support pour l'extension XML de PHP

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

## Installation de wget

wget est un utilitaire en ligne de commande pour télécharger de fichiers depuis le Web. Il supporte les protocoles HTTP, HTTPS et FTP ainsi que le téléchargement sur des serveurs HTTP à travers des proxies.

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install wget
  ```

## Installation de Composer

- À la date ou j'écris ce document la dernière version de `Composer` disponible est la version `2.6.5` et la dernière version disponible dans les dépots `apt` est la version `2.5.8`.

### Installation simple d'une version récente de Composer

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install composer
  ```

### Installation de la dernière version de Composer

**Composer est un gestionnaire de dépendances PHP qui permet d'installer et de mettre à jour facilement des bibliothèques tierces ou des frameworks comme CodeIgniter.**

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

## Licence

doc_codeigniter.md

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
