# Documentation Laravel

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

- [Documentation Laravel](#documentation-laravel)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation de Laravel](#installation-de-laravel)
    - [Installation de Laravel CLI](#installation-de-laravel-cli)
  - [Configuration de Laravel](#configuration-de-laravel)
  - [Utilisation de Laravel](#utilisation-de-laravel)
    - [Création d'un projet Laravel](#création-dun-projet-laravel)
    - [Création de migration](#création-de-migration)
    - [Lancement d'un projet Laravel en local grâce au serveur web Apache](#lancement-dun-projet-laravel-en-local-grâce-au-serveur-web-apache)
    - [Lancement d'un projet Laravel en local grâce au serveur de développement de Laravel](#lancement-dun-projet-laravel-en-local-grâce-au-serveur-de-développement-de-laravel)
    - [Rendre le serveur de développement de laravel accessible sur tout les appareils d'un réseau local](#rendre-le-serveur-de-développement-de-laravel-accessible-sur-tout-les-appareils-dun-réseau-local)

<div class="page"></div>

## Installation de Laravel

- Documentation officiel, complète et très bien expliqué
  > <https://laravel.com/docs/10.x>
- Source
  > <https://www.webhi.com/how-to/how-to-install-laravel-on-ubuntu-debian-apache-nginx/>

- Installer les différentes dépendances PHP dont Laravel à besoin

  ```shell
  sudo apt install php php-cli php-common php-mbstring php-xml php-zip php-mysql php-pgsql php-sqlite3 php-json php-bcmath php-gd php-tokenizer php-xmlwriter
  ```

- [Installer Composer](./doc_developpement_web.md#composer)
- [Installer le serveur web Apache pour php](./doc_developpement_web.md#apache)

### Installation de Laravel CLI

- Installation de Laravel CLI grâce à `Composer`

  ```shell
  composer global require laravel/installer
  ```

## Configuration de Laravel

- Configuration des permissions dans votre projet Laravel

  ```shell
  sudo chown -R www-data:www-data /path/to/your-project-name
  sudo chmod -R 755 /path/to/your-project-name
  ```

## Utilisation de Laravel

### Création d'un projet Laravel

- Créer un projet Laravel grâce à `Composer`

  ```shell
  composer create-project --prefer-dist laravel/laravel your-project-name
  ```

- Créer un projet Laravel grâce à la commande `laravel`

  ```shell
  laravel new your-project-name
  ```

- Créer un projet Laravel avec une version spécifique

  ```shell
  composer create-project --prefer-dist laravel/laravel your-project-name "8.*"
  ```

### Création de migration

### Lancement d'un projet Laravel en local grâce au serveur web Apache

- Si vous n'avez pas créer le projet Laravel dans le dossier `/var/www/html` il faut créer un lien symbolique entre le dossier du projet Laravel et le dossier `/var/www/html`

  ```shell
  sudo ln -s /path/to/your-project-name /var/www/html/your-project-name
  ```

- Créer un fichier de configuration pour le projet Laravel

  ```shell
  sudo nano /etc/apache2/sites-available/your-project-name.conf
  ```

- Ajouter le code suivant dans le fichier de configuration

  ```xml
  <VirtualHost *:80>
      ServerName your-domain-or-ip
      DocumentRoot /var/www/html/your-project-name/public
      <Directory /var/www/html/your-project-name>
          AllowOverride All
      </Directory>
  </VirtualHost>
  ```

- Activez le module de réécriture Apache :

  ```shell
  sudo a2enmod rewrite
  ```

- Activez l'hôte virtuel :

  ```shell
  sudo a2ensite your-project-name.conf
  ```

- Redémarrez Apache pour que les modifications prennent effet :

  ```shell
  sudo systemctl restart apache2
  ```

### Lancement d'un projet Laravel en local grâce au serveur de développement de Laravel

- Lancez le serveur web de développement de Laravel

  ```shell
  php artisan serve
  ```

  - Si vous avez cette erreur `The stream or file "/path/to/your-project-name/storage/logs/laravel.log" could not be opened: failed to open stream: Permission denied` il faut modifier le créateur du dossier `storage` et de son contenu
    - Source de la solution
      > <https://stackoverflow.com/questions/30639174/laravel-5-ubuntu-14-04-permission-denied-on-storage-log>

    ```shell
    sudo chown -R ${USER}:www-data /path/to/your-project-name/storage
    ```
  
    - Redonnez les droits au dossier `storage` si nécessaire

      ```shell
      sudo chmod -R 775 /path/to/your-project-name/storage
      ```

    - Relancez le serveur web de développement de Laravel

      ```shell
      php artisan serve
      ```

### Rendre le serveur de développement de laravel accessible sur tout les appareils d'un réseau local

- Lancer le serveur laravel avec la commande suivante

  ```shell
  php artisan serve --host=0.0.0.0 --port=8000
  ```

- Récupérer l'adresse IP ou le nom de la machine sur laquel le serveur laravel est lancé

  - Récupérer l'adresse IP sous Linux

    ```shell
    hostname -I
    ```
  
  - Récupérer le nom de la machine sous Linux

    ```shell
    hostname
    ```

  - Récupérer l'adresse IP sous Windows

    ```shell
    ipconfig
    ```
  
  - Récupérer l'adresse IP sous Windows grâce à l'inteface graphique
    - <https://support.microsoft.com/en-us/windows/find-your-ip-address-in-windows-f21a9bbc-c582-55cd-35e0-73431160a1b9>

- Ouvrir un navigateur sur un autre appareil connecté au même réseau
- Entrer l'adresse IP de la machine sur lequel le serveur laravel est lancé suivi du numéro de port, en l'occurence "`:8000`"

  ```shell
  <adresse_ip>:8000
  ```

  OU

  ```shell
  <nom>:8000
  ```

  - En règle général l'adresse IP est de la forme `192.168.1.XX`

    ```shell
    192.168.1.XX:8000
    ```

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
