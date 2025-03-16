# Documentation complète pour SSH

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

- [Documentation complète pour SSH](#documentation-complète-pour-ssh)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation de SSH](#installation-de-ssh)
    - [Installation du client SSH](#installation-du-client-ssh)
    - [Installation du serveur SSH](#installation-du-serveur-ssh)
    - [Installation de SSH FileSystem (SSHFS)](#installation-de-ssh-filesystem-sshfs)
  - [Configuration de SSH](#configuration-de-ssh)
    - [Configuration du client SSH](#configuration-du-client-ssh)
    - [Configuration du serveur SSH](#configuration-du-serveur-ssh)
  - [Utilisation de SSH](#utilisation-de-ssh)
    - [Mise en place d'un serveur SSH](#mise-en-place-dun-serveur-ssh)
    - [Connexion à un serveur](#connexion-à-un-serveur)
    - [Transfert de fichier](#transfert-de-fichier)
    - [Monter un système de fichier distant](#monter-un-système-de-fichier-distant)
  - [Licence](#licence)

<div class="page"></div>

## Installation de SSH

### Installation du client SSH

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install openssh-client
  ```

### Installation du serveur SSH

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install openssh-server
  ```

### Installation de SSH FileSystem (SSHFS)

**SSHFS permet de monter un système de fichier distant sur son système local via SSH.**

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install sshfs
  ```

## Configuration de SSH

### Configuration du client SSH

- Générer une clé SSH :

  ```shell
  ssh-keygen -t rsa -b 4096 -C "votre adresse mail"
  ```

- laisser vide les trois champs suivant :

  > Enter file in which to save the key (/home/$USER/.ssh/id_rsa):

  > Enter passphrase (empty for no passphrase):

  > Enter same passphrase again:

- Ajouter la clé public (présente dans le fichier `~/.ssh/id_rsa.pub`) sur le serveur SSH.

### Configuration du serveur SSH

## Utilisation de SSH

### Mise en place d'un serveur SSH

- Autoriser le trafic SSH sur le port 22 :

  ```bash
  sudo ufw allow ssh
  ```

- Éxecuter la commande suivante pour démarrer le serveur SSH :

  ```bash
  sudo systemctl start ssh
  ```

- Pour démarrer le serveur SSH au démarrage du système :

  ```bash
  sudo systemctl enable ssh
  ```

- Pour vérifier l'état du serveur SSH :

  ```bash
  sudo systemctl status ssh
  ```

- Pour redémarrer le serveur SSH :

  ```bash
  sudo systemctl restart ssh
  ```

- Pour arrêter le serveur SSH :

  ```bash
  sudo systemctl stop ssh
  ```

### Connexion à un serveur

- Se connecter à un serveur SSH :

  ```bash
  ssh <user>@<host>
  ```

  - `<user>` : Nom d'utilisateur à utiliser sur le serveur
  - `<host>` : Adresse IP ou nom de domaine

### Transfert de fichier

- Transférer un fichier vers un serveur SSH :

  ```bash
  scp <fichier> <user>@<host>:<destination>
  ```

  - `<fichier>` : Fichier local à transférer
  - `<user>` : Nom d'utilisateur à utiliser sur le serveur
  - `<host>` : Adresse IP ou nom de domaine
  - `<destination>` : Destination du fichier sur le serveur

### Monter un système de fichier distant

- [Installer SSHFS](#installation-de-ssh-filesystem-sshfs)
- Créer un dossier dans lequel sera monter le système de fichier distant :

  ```bash
  mkdir <dossier>
  ```

  - `<dossier>` : Nom du dossier
- Monter le système de fichier distant :

  ```bash
  sshfs <user>@<host>:/path/to/distant/folder /local/empty/folder
  ```

  - `<user>` : Nom d'utilisateur à utiliser sur le serveur
  - `<host>` : Adresse IP ou nom de domaine du serveur
  - `/path/to/distant/folder` : Chemin du dossier distant à monter
  - `/local/folder` : Chemin du dossier local (créé précédemment)

## Licence

doc_ssh.md

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
