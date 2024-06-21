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
  - [Installation](#installation)
    - [Installation de Laravel CLI](#installation-de-laravel-cli)
  - [Configuration](#configuration)
  - [Utilisation](#utilisation)
    - [Création d'un projet Laravel](#création-dun-projet-laravel)
    - [Lancement d'un projet Laravel en local grâce au serveur web Apache](#lancement-dun-projet-laravel-en-local-grâce-au-serveur-web-apache)
    - [Lancement d'un projet Laravel en local grâce au serveur de développement de Laravel](#lancement-dun-projet-laravel-en-local-grâce-au-serveur-de-développement-de-laravel)

<div class="page"></div>

## Installation

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

## Configuration

- Configuration des permissions dans votre projet Laravel

  ```shell
  sudo chown -R www-data:www-data /path/to/your-project-name
  sudo chmod -R 755 /path/to/your-project-name
  ```

## Utilisation

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
