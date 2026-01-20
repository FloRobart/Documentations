# Documentation complète pour SSH

## Table des matières

- [Documentation complète pour SSH](#documentation-complète-pour-ssh)
    - [Table des matières](#table-des-matières)
    - [SSH Client](#ssh-client)
        - [Installation de SSH Client](#installation-de-ssh-client)
        - [Création et utilisation de clé SSH](#création-et-utilisation-de-clé-ssh)
        - [Ajout de la clé SSH à l'agent SSH](#ajout-de-la-clé-ssh-à-lagent-ssh)
        - [Ajout de raccourci pour la connexion SSH](#ajout-de-raccourci-pour-la-connexion-ssh)
        - [Utilisation de SSH Client](#utilisation-de-ssh-client)
            - [Connexion à un serveur distant](#connexion-à-un-serveur-distant)
            - [Transfert de fichier](#transfert-de-fichier)
    - [SSH Server](#ssh-server)
        - [Installation de SSH Server](#installation-de-ssh-server)
        - [Configuration de SSH Server](#configuration-de-ssh-server)
        - [Utilisation de SSH Server](#utilisation-de-ssh-server)
    - [SSH FileSystem (SSHFS)](#ssh-filesystem-sshfs)
        - [Installation de SSH FileSystem (SSHFS)](#installation-de-ssh-filesystem-sshfs)
        - [Monter un système de fichier distant](#monter-un-système-de-fichier-distant)
    - [Licence](#licence)

## SSH Client

### Installation de SSH Client

- Installer le paquet du dépot `apt` :

    ```bash
    sudo apt install openssh-client
    ```

### Création et utilisation de clé SSH

- Générer une clé SSH :

    ```shell
    ssh-keygen -t rsa -b 4096 -C "commentaire"
    ```

    - Il est recommandé de mettre un commentaire pour identifier la clé (par exemple l'utilisation qui va être faite de la clé)

- Entrer le nom du fichier dans lequel sauvegarder la clé (il est recommandé de mettre le dossier par défaut mais de changer le nom du fichier par l'utilisation qui va être faite de la clé) :

    > Enter file in which to save the key ($HOME/.ssh/id_rsa): `~/.ssh/id_rsa_<custom_name>`

- Entrer une passphrase pour sécuriser la clé. C'est un mot de passe qui sera demandé à chaque utilisation de la clé privée. Il est possible de laisser vide pour ne pas mettre de passphrase

    > Enter passphrase (empty for no passphrase):

- Confirmer la passphrase en la retapant

    > Enter same passphrase again:

- **Ajouter la clé public (présente dans le fichier `~/.ssh/id_rsa_<custom_name>.pub`) dans le fichier `~/.ssh/authorized_keys` du serveur distant.**

### Ajout de la clé SSH à l'agent SSH

- Vérifier que l'agent SSH est en cours d'exécution :

    ```bash
    echo $SSH_AUTH_SOCK
    ```

    - Si la commande ne retourne rien, cela signifie que l'agent SSH n'est pas en cours d'exécution

- Si l'agent SSH n'est pas en cours d'exécution, démarrer l'agent SSH

    ```bash
    eval "$(ssh-agent -s)"
    ```

- Ajouter la clé privée à l'agent SSH

    ```bash
    ssh-add ~/.ssh/<nom_de_la_clé>
    ```

    - `<nom_de_la_clé>` : Nom du fichier de la clé privée (généralement `id_rsa` ou `id_rsa_<custom_name>`)
- Vérifier que la clé a bien été ajoutée à l'agent SSH

    ```bash
    ssh-add -l
    ```

### Ajout de raccourci pour la connexion SSH

- Éditer (ou créer) le fichier de configuration SSH `~/.ssh/config` :

    ```bash
    nano ~/.ssh/config
    ```

- Ajouter une entrée pour le serveur SSH :

    ```plaintext
    Host <nom_du_raccourci>
        HostName <host>
        User <user>
        Port <port>
        IdentityFile ~/.ssh/<nom_de_la_clé>
        IdentitiesOnly yes
    ```

    - `<nom_du_raccourci>` : Nom du raccourci pour la connexion SSH
    - `<host>` : Adresse IP ou nom de domaine du serveur
    - `<user>` : Nom d'utilisateur à utiliser sur le serveur
    - `<port>` : Port SSH (par défaut 22)
    - `<nom_de_la_clé>` : Nom du fichier de la clé privée (généralement `id_rsa` ou `id_rsa_<custom_name>`)
- Sauvegarder et fermer le fichier
- Utiliser le raccourci pour se connecter au serveur distant avec SSH

    ```bash
    ssh <nom_du_raccourci>
    ```

- Normalement, la connexion SSH devrait s'établir sans demander de mot de passe si la clé SSH a été correctement configurée

### Utilisation de SSH Client

#### Connexion à un serveur distant

- Se connecter à un serveur SSH :

    ```bash
    ssh <user>@<host> -p <port>
    ```

    - `<user>` : Nom d'utilisateur à utiliser sur le serveur
    - `<host>` : Adresse IP ou nom de domaine
    - `<port>` : Port SSH (par défaut 22)

#### Transfert de fichier

- Transférer un fichier depuis l'hôte vers un serveur SSH :

    ```sh
    scp <fichier> <user>@<host>:<destination> -P <port>
    ```

    - `<fichier>` : Fichier local à transférer
    - `<user>` : Nom d'utilisateur à utiliser sur le serveur
    - `<host>` : Adresse IP ou nom de domaine
    - `<destination>` : Destination du fichier sur le serveur

- Transférer un fichier depuis un serveur SSH vers l'hôte :

    ```sh
    scp -P 7518 <user>@<host>:<fichier> <destination>
    ```

    - `<user>` : Nom d'utilisateur à utiliser sur le serveur
    - `<host>` : Adresse IP ou nom de domaine
    - `<fichier>` : Fichier distant à transférer sur l'hôte
    - `<destination>` : Destination du fichier en local

## SSH Server

### Installation de SSH Server

- Installer le paquet du dépot `apt` :

    ```bash
    sudo apt install openssh-server
    ```

### Configuration de SSH Server

- Cette section n'est pas obligatoire, mais est fortement recommandée pour sécuriser le serveur SSH.
- Éditer le fichier de configuration SSH `/etc/ssh/sshd_config` :

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
        ...
        PermitRootLogin no
        ...
        ```

    - Sauvegarder et quitter.
- Redémarrer le service SSH.

    ```bash
    sudo service ssh restart
    ```

- Créer une clé SSH pour se connecter au serveur (voir [Création et utilisation de clé SSH](#création-et-utilisation-de-clé-ssh)).
- Ajouter la clé publique dans le fichier `~/.ssh/authorized_keys` (Normalement vous l'avez déjà fait lors de l'étape précédente).
- Redémarrer le service SSH.

    ```bash
    sudo service ssh restart
    ```

- Essayer de se connecter au serveur SSH en utilisant la clé SSH

    ```bash
    ssh -i ~/.ssh/<nom_de_la_clé> <user>@<host> -p <port>
    ```

    - `<nom_de_la_clé>` : Nom du fichier de la clé privée (généralement `id_rsa` ou `id_rsa_<custom_name>`)
    - `<user>` : Nom d'utilisateur à utiliser sur le serveur
    - `<host>` : Adresse IP ou nom de domaine
    - `<port>` : Port SSH (celui que vous avez configuré précédemment)
- Si la connexion fonctionne correctement, vous pouvez désactiver l'authentification par mot de passe pour renforcer la sécurité.
- **/!\ Attention /!\\** : Avant de désactiver l'authentification par mot de passe, assurez-vous que vous pouvez vous connecter au serveur SSH avec la clé SSH. Sinon, vous risquez de vous retrouver bloqué hors du serveur.
- Éditer le fichier de configuration SSH `/etc/ssh/sshd_config`

    ```bash
    sudo nano /etc/ssh/sshd_config
    ```

    - Modifier la ligne `PasswordAuthentication` pour qu'elle soit égale à `no`.

        ```txt
        # This is the sshd server system-wide configuration file.  See
        # sshd_config(5) for more information.

        ...
        PasswordAuthentication no
        ...
        UsePAM no
        ...
        ```

    - Sauvegarder et quitter.
- Redémarrer le service SSH.

    ```bash
    sudo service ssh restart
    ```

- Vérifier que l'authentification par mot de passe est désactivée

    ```bash
    sudo sshd -T | grep -E "passwordauthentication|usepam"
    ```

    - Les deux lignes retournées doivent être `passwordauthentication no` et `usepam no`.
- Vérifier que la connexion SSH fonctionne toujours avec la clé SSH.

    ```bash
    ssh -i ~/.ssh/<nom_de_la_clé> <user>@<host> -p <port>
    ```

### Utilisation de SSH Server

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

## SSH FileSystem (SSHFS)

### Installation de SSH FileSystem (SSHFS)

**SSHFS permet de monter un système de fichier distant sur son système local via SSH.**

- Installer le paquet du dépot `apt` :

    ```bash
    sudo apt install sshfs
    ```

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
