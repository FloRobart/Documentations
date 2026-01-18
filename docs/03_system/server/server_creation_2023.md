# Documentation sur la création d'un serveur (Obselète - 2023)

## Veillez consulter la documentation plus récente pour la création d'un serveur : [Création d'un serveur (2026)](server_creation_2026.md)

## Table des matières

- [Documentation sur la création d'un serveur (Obselète - 2023)](#documentation-sur-la-création-dun-serveur-obselète---2023)
    - [Veillez consulter la documentation plus récente pour la création d'un serveur : Création d'un serveur (2026)](#veillez-consulter-la-documentation-plus-récente-pour-la-création-dun-serveur--création-dun-serveur-2026)
    - [Table des matières](#table-des-matières)
    - [Préambule](#préambule)
    - [Récupération du matériel](#récupération-du-matériel)
    - [OS Debian](#os-debian)
    - [SSH](#ssh)
    - [Licence](#licence)

## Préambule

- Source

    > [Playlist Youtube de Grafikart](https://www.youtube.com/watch?v=cfJh8vdKuQU&list=PLjwdMgw5TTLUnvhOKLcpCG8ORQsfE7uB4)

Certains passages de la playlist de Grafikart sont obsolètes (Janvier 2025), j'ai donc pris d'autre source pour les parties qui ne fonctionnaient pas. Les autres sources seront indiquées de la même façon que celle-ci dans les parties concernées.

Le maître mot de ce tutoriel est la **sécurité**. Faire un serveur c'est bien mais faire un serveur sécurisé c'est mieux. C'est pourquoi, en plus de faire les étapes de base pour créer un serveur web, je vais vous montrer comment sécuriser votre serveur.

Dans ce tutoriel couvrira :

- L'installation du système d'exploitation Debian
- L'installation de SSH
- La configuration du serveur SSH

## Récupération du matériel

Vous pouvez créer un serveur avec n'importe quel ordinateur. Personnellement, j'utilise un ancien ordinateur de burreau qui à une dizaine d'années.

## OS Debian

Je vais utiliser Debian server pour ce tutoriel.

- Télécharger l'image ISO de Debian server sur le site officiel de Debian.

    > <https://www.debian.org/>
    - Debian ne possède pas d'image particulières pour les serveurs, il faut donc télécharger l'image de l'installation de base de Debian. Pendant l'installation, nous ne sélectionnerons pas d'environnement graphique puisque nous n'en avons pas besoin pour un serveur.
- Démarrer l'ordinateur sur la clé USB.
- Selectionner l'image ISO de Debian server.
- Selectionner la langue.
- Entrer le nom de la machine
- Entrer le domaine (laisser vide si vous n'en avez pas). Si vous en avez un c'est ici qu'il entrer votre nom de domaine.
- Entrer le mot de passe de l'utilisateur `root`.
- Confirmer le mot de passe.
- Entrer le nom de l'utilisateur courant.
- Entrer le mot de passe de l'utilisateur courant.
- Confirmer le mot de passe.
- Selectionner le partitionnement du disque dur.
- Selectionner le pays pour le miroir des paquets.
- Selectionner le miroir des paquets `deb.debian.org`.
- Entrer le proxy (laisser vide si vous n'en avez pas).
- Selectionner si vous voulez participer à l'envoi de données anonymes.
- Selectionner les paquets à installer.
    - Serveur SSH
    - utilitaires usuels du système
- Installer le chargeur d'amorçage GRUB. (Si vous avez déjà GRUB, il ne vous sera pas demandé de l'installer)
- Cliquer sur `continuer` pour redémarrer l'ordinateur.
- Cliquer sur `Debian/GNU` pour démarrer le système.
- Entrer le nom d'utilisateur créé précédemment.
- Entrer le mot de passe.

Vous avez maintenant un serveur Debian fonctionnel sur lequel vous êtes connecté en tant qu'utilisateur courant.

- Passer en mode super utilisateur.

    ```bash
    su root
    ```

- Mettre à jour les paquets.

    ```bash
    apt update
    ```

- Installer sudo.

    ```bash
    apt install sudo
    ```

- Ajouter l'utilisateur courant au groupe sudo.

    ```bash
    usermod -aG sudo <nom_utilisateur>
    ```

- Se connecter en tant qu'utilisateur courant.

    ```bash
    su <nom_utilisateur>
    ```

- Testez si sudo fonctionne.

    ```bash
    sudo date
    ```

    - Résultat attendu : `la date actuelle`

## SSH

- Changer la configuration de SSH pour plus de sécurité.

    ```bash
    sudo nano /etc/ssh/sshd_config
    ```

    - Modifier la ligne `Port` pour changer le numéro de port par défaut.
        - Vous pouvez choisir presque n'importe quel numéro de port entre 1024 et 65535.
    - Modifier la ligne `PermitRootLogin` pour qu'elle soit égale à `no`.

        ```txt
        # This is the sshd server system-wide configuration file.  See
        # sshd_config(5) for more information.

        ...

        Port <port>

        ...

        PermitRootLogin no

        ...
        ```

    - Sauvegarder et quitter.

- Redémarrer le service SSH.

    ```bash
    sudo service ssh restart
    ```

- Créer une clé SSH **sur votre ordinateur.**

    ```bash
    ssh-keygen -t rsa -b 4096 -C "<email>"
    ```

    - Entrer le nom du fichier de la clé (laisser vide pour utiliser le nom par défaut).
    - Entrer une passphrase (optionnel mais plus sécurisé).
    - Confirmer la passphrase.

- Connectez-vous au serveur en SSH.

    ```bash
    ssh <nom_utilisateur>@<adresse_ip> -p <port>
    ```

    - Entrer le mot de passe de l'utilisateur.
- Créer le dossier `.ssh` dans le dossier de l'utilisateur.

    ```bash
    mkdir -m 700  ~/.ssh
    ```

- Créer le fichier `authorized_keys` dans le dossier `.ssh`.

    ```bash
    touch ~/.ssh/authorized_keys
    ```

- Copier la clé publique de votre ordinateur dans le fichier `authorized_keys`.
- Modifier les permissions du fichier `authorized_keys`.

    ```bash
    chmod 600 ~/.ssh/authorized_keys
    ```

## Licence

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
