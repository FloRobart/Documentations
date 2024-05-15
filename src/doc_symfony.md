# Documentation installation et utilisation du framework PHP Symfony

<a href="../README.md"><button type="button">Retour à toute les documentations</button></a>

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

***

- [Documentation installation et utilisation du framework PHP Symfony](#documentation-installation-et-utilisation-du-framework-php-symfony)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation de Symfony sous Linux (Ubuntu)](#installation-de-symfony-sous-linux-ubuntu)
    - [Installation à réaliser - Linux](#installation-à-réaliser---linux)
    - [Installation de la dernière version de PHP - Linux](#installation-de-la-dernière-version-de-php---linux)
    - [Installation de Git - Linux](#installation-de-git---linux)
    - [Installation de curl - Linux](#installation-de-curl---linux)
    - [Installation de Composer - Linux](#installation-de-composer---linux)
      - [Installation simple d'une version récente de Composer - Linux](#installation-simple-dune-version-récente-de-composer---linux)
      - [Installation de la dernière version stable de Composer - Linux](#installation-de-la-dernière-version-stable-de-composer---linux)
    - [Symfony CLI - Linux](#symfony-cli---linux)
      - [Installation de Symfony CLI - Linux](#installation-de-symfony-cli---linux)
      - [Utilisation de Symfony CLI - Linux](#utilisation-de-symfony-cli---linux)
  - [Installation de Symfony sous Windows 11](#installation-de-symfony-sous-windows-11)
    - [Installation à réaliser - Windows](#installation-à-réaliser---windows)
    - [Installation de la dernière version de PHP - Windows](#installation-de-la-dernière-version-de-php---windows)
      - [Première méthode](#première-méthode)
      - [Deuxième méthode](#deuxième-méthode)
    - [Installation de Git - Windows](#installation-de-git---windows)
    - [Installation de Scoop - Windows](#installation-de-scoop---windows)
      - [Installation de la dernière version stable de Composer - Windows](#installation-de-la-dernière-version-stable-de-composer---windows)
    - [Symfony CLI - Windows](#symfony-cli---windows)
      - [Installation de Symfony CLI - Windows](#installation-de-symfony-cli---windows)
      - [Utilisation de Symfony CLI - Windows](#utilisation-de-symfony-cli---windows)

<div class="page"></div>

## Installation de Symfony sous Linux (Ubuntu)

***

### Installation à réaliser - Linux

- [Installer **PHP**](#installation-de-la-dernière-version-de-php---linux)
- [Installer **Git**](#installation-de-git---linux)
- [Installer **curl**](#installation-de-curl---linux)
- [Installer **la dernière version de Composer**](#installation-de-composer---linux)
- [Installer **Symfony CLI**](#installation-de-symfony-cli---linux)

### Installation de la dernière version de PHP - Linux

- Installer php ainsi que toute ces dépendances et outils de développement depuis le dépot `apt` :

  ```bash
  sudo apt install php-common php-cli php-pgsql php-curl php-xml php-json php-dev
  ```

  - **php-common :** Fournit les fichiers communs pour la dernière version stable de PHP
  - **php-cli :** Fournit l'interface de ligne de commande pour PHP
  - **php-pgsql :** Fournit un module de support pour l'extension PostgreSQL de PHP
  - **php-curl :** Fournit un module de support pour l'extension CURL de PHP
  - **php-json :** Fournit un module de support pour l'extension JSON de PHP
  - **php-xml :** Fournit un module de support pour l'extension XML de PHP
  - **php-dev :** Fournit les fichiers de développement pour la dernière version stable de PHP

- Si l'extension `php-pgsql` ne fonctionne pas il peut être nécessaire de l'activer dans les fichiers de configuration '`/etc/php/<version>/cli/php.ini`' :

  ```bash
  extension=php_pgsql.so
  ```

- Pour vérifier que php est bien installé avec la bonne version tapé la commande suivante dans un terminal :

  ```bash
  php -v
  ```

  - Sortie attendu de la commande :

    ```shell
    PHP 8.2.10-2ubuntu1 (cli) (built: Sep  5 2023 14:37:47) (NTS)
    Copyright (c) The PHP Group
    Zend Engine v4.2.10, Copyright (c) Zend Technologies
        with Zend OPcache v8.2.10-2ubuntu1, Copyright (c), by Zend Technologies
    ```

### Installation de Git - Linux

- Installer le paquet `git` depuis le dépot `apt` :

  ```shell
  sudo apt install git
  ```

- Pour vérifier l'installation ouvrez un terminal et lancer la commande :

  ```shell
  git --version
  ```

  - Résultat attendu :

    ```shell
    git version 2.40.1
    ```

### Installation de curl - Linux

wget est un utilitaire en ligne de commande pour télécharger de fichiers depuis le Web. Il supporte les protocoles HTTP, HTTPS et FTP ainsi que le téléchargement sur des serveurs HTTP à travers des proxies.

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install curl
  ```

### Installation de Composer - Linux

#### Installation simple d'une version récente de Composer - Linux

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install composer
  ```

#### Installation de la dernière version stable de Composer - Linux

**Composer est un gestionnaire de dépendances PHP qui permet d'installer et de mettre à jour facilement des bibliothèques tierces ou des frameworks comme CodeIgniter ou Symfony.**

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

- Créer un projet en utilisant Symfony et Composer :
  - N'utiliser pas cette méthode pour créer un projet Symfony, utiliser plutôt Symfony CLI

  ```bash
  composer create-project symfony/website-skeleton <nameApp>
  ```

### Symfony CLI - Linux

#### Installation de Symfony CLI - Linux

**Symfony CLI est un outil en ligne de commande qui permet de créer et de gérer des projets Symfony. Techniquement Composer peut faire la même chose, mais Symfony CLI est devenu l'outils officiel pour gérer les projets Symfony, de plus dans les dernière version il est devenu plus rapide et pertinant que Composer parce qu'il supprime les fichiers inutile.**

- Télécharger l'installateur de Symfony CLI

  ```shell
  curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
  ```

- Installer Symfony CLI

  ```shell
  sudo apt install symfony-cli
  ```

- Vérifier l'installation

  ```shell
  symfony -V
  ```

  - Résultat attendu :

    ```shell
    Symfony CLI version 5.7.5 (c) 2021-2023 Fabien Potencier (2023-12-07T15:46:32Z - stable)
    ```

#### Utilisation de Symfony CLI - Linux

- Créer une nouvelle webapp Symfony

  ```shell
  symfony new --webapp <nameApp>
  ```

- Ajouter un package à un projet Symfony

  ```shell
  composer require <packageName>
  ```

<div class="page"></div>

## Installation de Symfony sous Windows 11

***

### Installation à réaliser - Windows

- [Installer **PHP**](#installation-de-la-dernière-version-de-php---windows)
- [Installer **Git**](#installation-de-git---windows)
- [Installer **Scoop**](#installation-de-scoop---windows)
- [Installer **la dernière version de Composer**](#installation-de-la-dernière-version-stable-de-composer---windows)
- [Installer **Symfony CLI**](#symfony-cli---windows)

### Installation de la dernière version de PHP - Windows

#### Première méthode

- Télécharger le fichier zip de la dernière version de PHP sur le site officiel
  > <https://windows.php.net/download/>

- créer un dossier `php` dans le dossier `C:\`

  ```powershell
  mkdir C:\php
  ```

- Extraire le contenu du fichier zip dans le dossier `C:\php`
  
  ```powershell
  Expand-Archive -Path php-8.3.0-nts-Win32-vs16-x64.zip -DestinationPath C:\php\
  ```

- Supprimer le fichier zip

  ```powershell
  rm php-8.3.0-nts-Win32-vs16-x64.zip
  ```

- Ajouter le dossier `C:\php` dans la variable d'environnement `PATH`
  - ajouter les screens

- Pour vérifier que php est bien installé avec la bonne version tapé la commande suivante dans un terminal :

  ```powershell
  php -v
  ```

  - Sortie attendu de la commande :

    ```powershell
    PHP 8.3.0 (cli) (built: Sep  5 2023 14:37:47) (NTS)
    ```

#### Deuxième méthode

- [Installer Scoop](#installation-de-scoop---windows)
- Installer la dernière version de PHP avec scoop

  ```powershell
  scoop install php
  ```

### Installation de Git - Windows

- Télécharger le fichier d'installation sur le site officiel :
  > <https://git-scm.com/download/win>

- Ouvrir le fichier d'installation
- Suivre les instructions d'installation
- Séléctionner l'option '`Add a Git Bash Profile to Windows Terminal`'
- Ne pas séléctionner l'option '`Use Git from Git Bash only`' pour pouvoir utiliser git depuis le terminal windows
- Changer l'éditeur de texte par défaut si vous en avez envie
- Laisser toutes les autres options par défaut
- Cliquer sur '`Install`'
- Pour vérifier l'installation ouvrez un terminal et lancer la commande :

  ```powershell
  git --version
  ```

  - Résultat attendu :

    ```powershell
    git version 2.43.0.windows.1
    ```

### Installation de Scoop - Windows

**Scoop est un gestionnaire de paquets pour Windows. Il permet d'installer des logiciels en ligne de commande.**

- Ouvrir un terminal `PowerShell`
- Exécuter la commande suivante :

  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

- Exécuter la commande suivante :

  ```powershell
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  ```

#### Installation de la dernière version stable de Composer - Windows

**Composer est un gestionnaire de dépendances PHP qui permet d'installer et de mettre à jour facilement des bibliothèques tierces ou des frameworks comme CodeIgniter ou Symfony.**

- Vous pouvez trouver la documentation officielle de `Composer` à l'adresse suivante :
  ><https://getcomposer.org/download/>

- Placez vous dans le repertoire de votre choix, dans cas `/home/${USER}` :

  ```bash
  cd /home/${USER}
  ```

- Télécharger le fichier d'installation de Composer

  ```powershell
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ```

- Vérifier que le fichier `composer-setup.php` est bien le bon

  ```powershell
  php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installateur vérifié'; } else { echo 'Installateur corrompu'; unlink('composer-setup.php'); } echo PHP_EOL;"
  ```

- Exécuter le fichier d'installation `composer-setup.php`

  ```powershell
  php composer-setup.php
  ```

- Effacer le fichier d'installation `composer-setup.php`

  ```powershell
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

- Pour tout les utilisateurs (Besoin de droit d'administration)

    ```bash
    sudo mv composer.phar /usr/bin/composer
    ```

- Créer un projet en utilisant Symfony et Composer :
  - N'utiliser pas cette méthode pour créer un projet Symfony, utiliser plutôt Symfony CLI

  ```bash
  composer create-project symfony/website-skeleton <nameApp>
  ```

### Symfony CLI - Windows

#### Installation de Symfony CLI - Windows

**Symfony CLI est un outil en ligne de commande qui permet de créer et de gérer des projets Symfony. Techniquement Composer peut faire la même chose, mais Symfony CLI est devenu l'outils officiel pour gérer les projets Symfony, de plus dans les dernière version il est devenu plus rapide et pertinant que Composer parce qu'il supprime les fichiers inutile.**

- Installer symfony CLI

  ```powershell
  scoop install symfony-cli
  ```

- Vérifier l'installation

  ```powershell
  symfony -V
  ```

  - Résultat attendu :

    ```powershell
    Symfony CLI version 5.7.5 (c) 2021-2023 Fabien Potencier (2023-12-07T15:46:32Z - stable)
    ```

#### Utilisation de Symfony CLI - Windows

- Créer une nouvelle webapp avec Symfony

  ```powershell
  symfony new --webapp <nameApp>
  ```

- Ajouter un package à un projet Symfony

  ```powershell
  composer require <packageName>
  ```
