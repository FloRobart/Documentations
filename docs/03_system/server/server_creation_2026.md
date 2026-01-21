# Documentation sur la création d'un serveur

## Table des matières

- [Documentation sur la création d'un serveur](#documentation-sur-la-création-dun-serveur)
    - [Table des matières](#table-des-matières)
    - [Prérequis](#prérequis)
    - [Configuration du démarrage à distance Wake-on-LAN (WOL)](#configuration-du-démarrage-à-distance-wake-on-lan-wol)
    - [Installation du système d'exploitation Debian](#installation-du-système-dexploitation-debian)
    - [Configuration de l'adresse IP fixe](#configuration-de-ladresse-ip-fixe)
    - [Installation et configuration des dépendances de base](#installation-et-configuration-des-dépendances-de-base)
        - [Sudo](#sudo)
        - [SSH](#ssh)
            - [Connexion à distance via SSH](#connexion-à-distance-via-ssh)
        - [Git](#git)
    - [Configuration supplémentaire (optionnelle)](#configuration-supplémentaire-optionnelle)
        - [Installation et configuration de Docker et Docker Compose](#installation-et-configuration-de-docker-et-docker-compose)
        - [Installation et configuration de Prometheus](#installation-et-configuration-de-prometheus)
        - [Installation et configuration de Grafana](#installation-et-configuration-de-grafana)
    - [Licence](#licence)

## Prérequis

- Du matériel pour faire le serveur
    - Un ordinateur (ancien PC de bureau, Raspberry Pi, etc.)
    - Une connexion internet (Ethernet recommandé, préférable au Wi-Fi)
    - *Un câble Ethernet* (Optionnel)
- Une clé USB bootable avec le fichier d'installation de Debian
    - Si vous ne savez pas comment faire une clé USB bootable, suivez ce guide : [Créer une clé USB bootable](../../02_applications/ventoy.md)

## Configuration du démarrage à distance Wake-on-LAN (WOL)

**Wake-on-LAN** permet de rallumer un PC éteint via Ethernet, en envoyant un **magic packet**. le Wake-on-LAN ne fonctionne que si le PC est éteint mais toujours alimenté (c'est-à-dire en mode veille ou éteint via le système d'exploitation, mais pas débranché ou coupé de l'alimentation).

Noté que vous n'aurez pas forcément toutes les options décrites ci-dessous dans votre BIOS / UEFI, cela dépend du fabricant de la carte mère et du BIOS / UEFI utilisé.

- Éteindre le PC que vous souhaitez utiliser comme serveur.
- Brancher un clavier et un écran à l'ordinateur (ils pourront être retirés après l'étape de [Connexion à distance via SSH](#connexion-à-distance-via-ssh), mais sont obligatoires pour l'installation initiale).

- Démarrer l'ordinateur et accéder au menu de démarrage **BIOS** / **UEFI** (généralement en appuyant sur une touche comme F12, F2, DEL, etc. au démarrage).
- Dans le BIOS / UEFI, naviguer jusqu'à la section **Power Management** ou **Advanced Settings --> APM** (le nom peut varier selon les fabricants).
- Rechercher une option nommée **Wake-on-LAN**, **Power on by PCI-E**, **Resume by LAN**, **Wake Up by LAN** ou similaire. Cette permet le réveil du PC via la carte réseau.
- Sélectionner cette option et la définir sur **Enabled**.
- Rechercher une option nommée **ERP Ready**, **Power Off Energy Saving** ou **Deep Power Off** ou similaire. Cette option permet de réduire la consommation d'énergie lorsque le PC est éteint mais empêche le réveil via la carte réseau (le gain de consommation d'énergie est généralement très faible, voir négligeable, quelques milliwatts).
- Rechercher une option nommée **ASPM** ou **Energy Efficient Ethernet** ou similaire.
- Sélectionner cette option et la définir sur **Disabled**. Cette option permet de définir le mode d'économie d'énergie des services PCIe (dont la carte réseau, le GPU, la NVMe fait partie), ce qui peut interférer avec le Wake-on-LAN si l'option est activée.
- Sauvegarder les modifications et quitter le **BIOS** / **UEFI** (souvent `F10`).

- L'ordinateur devrait redémarrer normalement.
- Maintenant, le Wake-on-LAN est activé sur votre PC, mais il y a encore quelques étapes à faire dans le système d'exploitation pour que cela fonctionne correctement.
- Si ce n'est pas déjà fait, installer Debian sur le PC en suivant les étapes de la section [Installation du système d'exploitation Debian](#installation-du-système-dexploitation-debian).
- Si ce n'est pas déjà fait, installer les dépendances de base en suivant les étapes de la section [Installation et configuration des dépendances de base](#installation-et-configuration-des-dépendances-de-base).
- Ouvrir un terminal sur le serveur (soit directement sur le PC, soit en SSH depuis un autre ordinateur).
- Installer le paquet `ethtool` qui permet de configurer les options de la carte réseau.

    ```bash
    sudo apt update && sudo apt install ethtool
    ```

- Récupérer le nom de l'interface réseau.

    ```bash
    ip a
    ```

- Dans la liste des interfaces, repérer celle qui correspond à la connexion Ethernet (généralement nommée `eth0`, `enpXsY` ou similaire, où `X` et `Y` sont des chiffres). Noter ce nom pour l'utiliser dans la commande suivante.
    - Vous pouvez vérifier que c'est la bonne interface en regardant le champ `inet` qui doit contenir l'adresse IP de votre serveur.
- Noté l'adresse MAC de l'interface réseau (champ `link/ether`), elle sera utile plus tard.

    ```txt
    X: enpXsY: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether XX:XX:XX:XX:XX:XX brd XX:XX:XX:XX:XX:XX
    inet 192.168.1.XXX/XX brd 192.168.1.XXX scope global dynamic enpXsY
       valid_lft 85343sec preferred_lft 85343sec
    inet6 XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX/XX scope global dynamic mngtmpaddr 
       valid_lft 86371sec preferred_lft 14371sec
    inet6 XXXX::XXXX:XXXX:XXXX:XXXX/XX scope link 
       valid_lft forever preferred_lft forever
    ```

    - Dans cet exemple, l'interface est `enpXsY` et l'adresse MAC est `XX:XX:XX:XX:XX:XX` noté après `link/ether`.
- Vérifier que le Wake-on-LAN est activé sur l'interface réseau.

    ```bash
    sudo ethtool enpXsY
    ```

    - Dans la sortie de la commande, vérifier que la ligne `Wake-on:` est bien suivie de la lettre `g`, ce qui indique que le Wake-on-LAN est activé.

        ```txt
        ...
        Supports Wake-on: pumbg
        Wake-on: g
        ...
        ```

        - Si la ligne `Wake-on:` n'est pas suivie de la lettre `g` (souvent se sera un `d` pour `disabled`), c'est qu'il est désactivé.
- Activer le Wake-on-LAN sur l'interface réseau (N'oubliez pas de remplacer `enpXsY` par le nom de votre interface réseau).

    ```bash
    sudo ethtool -s enpXsY wol g
    ```

- Vérifier à nouveau que le Wake-on-LAN est activé (N'oubliez pas de remplacer `enpXsY` par le nom de votre interface réseau).

    ```bash
    sudo ethtool enpXsY
    ```

    - La ligne `Wake-on:` doit maintenant être suivie de la lettre `g`.

        ```txt
        ...
        Supports Wake-on: pumbg
        Wake-on: g
        ...
        ```

- Rendre cette modification permanente en créant un script qui sera exécuté au démarrage (si vous ne faites pas cela, votre modification sera perdue après un redémarrage).
    - Créer un nouveau service systemd.

        ```bash
        sudo nano /etc/systemd/system/wol.service
        ```

    - Coller le contenu suivant dans le fichier (en remplaçant `enpXsY` par le nom de votre interface réseau).

        ```ini
        [Unit]
        Description=Enable Wake-on-LAN
        After=network.target

        [Service]
        Type=oneshot
        ExecStart=/usr/sbin/ethtool -s enpXsY wol g

        [Install]
        WantedBy=multi-user.target
        ```

        - N'oubliez pas de remplacer `enpXsY` par le nom de votre interface réseau.
    - Sauvegarder et fermer le fichier (`Ctrl + X` puis `O` puis `Entrée`).
    - Activer le service pour qu'il se lance au démarrage.

        ```bash
        sudo systemctl daemon-reexec
        ```

    - Activer le service WOL.

        ```bash
        sudo systemctl enable wol
        ```

- Vérifier que le service est bien activé.

    ```bash
    systemctl is-enabled wol
    ```

    - Résultat attendu : `enabled`

Nous allons maintenant vérifier que le Wake-on-LAN fonctionne en éteignant le serveur et en envoyant un magic packet depuis un autre ordinateur.

- Éteindre le serveur.

    ```bash
    sudo shutdown now
    ```

Sur un autre ordinateur (avec n'importe quel OS mais cette doc ne couvre que Linux) connecté au même réseau local que le serveur :

- Installer l'outil `wakeonlan`.

    ```bash
    sudo apt install wakeonlan
    ```

- Envoyer le magic packet en utilisant l'adresse MAC notée précédemment.

    ```bash
    wakeonlan XX:XX:XX:XX:XX:XX
    ```

    - Remplacer `XX:XX:XX:XX:XX:XX` par l'adresse MAC de votre serveur que vous avez notée précédemment.
- Le serveur devrait s'allumer après l'envoi du magic packet.

## Installation du système d'exploitation Debian

/!\ Attention : Cette étape effacera toutes les données présentes sur le disque dur de l'ordinateur que vous utilisez comme serveur. Assurez-vous d'avoir sauvegardé toutes les données importantes avant de continuer. /!\

- Éteindre le PC que vous souhaitez utiliser comme serveur.
- Brancher un clavier et un écran à l'ordinateur (ils pourront être retirés après l'étape de [Connexion à distance via SSH](#connexion-à-distance-via-ssh), mais sont obligatoires pour l'installation initiale).
- Insérer la clé USB bootable dans un port USB de l'ordinateur.
- Démarrer l'ordinateur et accéder au menu de démarrage **BIOS** / **UEFI** (généralement en appuyant sur une touche comme F12, F2, DEL, etc. au démarrage).
- Dans la liste des périphériques de démarrage, sélectionner la clé USB et placer-la en première position.
- Sauvegarder les modifications et quitter le **BIOS** / **UEFI** (souvent `F10`).
- L'ordinateur devrait redémarrer et démarrer à partir de la clé USB.
- Un écran avec toutes les images disponibles sur la clé USB devrait apparaître.
- Sélectionner l'image d'installation de **Debian** ou de l'OS que vous voulez installer.
- Sélectionner `boot in normal mode`.
- Sélectionner le mode d'installation (`install` recommandé).
- L'installateur de Debian devrait se lancer.
- Sélectionner la langue.
- Sélectionner le pays.
- Sélectionner la disposition du clavier.
- Sélectionner l'interface réseau principale (généralement `enp2s0`).
- Entrer le nom de la machine
- Entrer le domaine (laisser par défaut si vous n'en avez pas). Si vous en avez un c'est ici qu'il entrer votre nom de domaine.
- Entrer le mot de passe de l'utilisateur `root`. Je recommande de le laisser vide pour désactiver le compte root et utiliser `sudo` à la place.
- Confirmer le mot de passe (laisser vide si vous avez laissé le mot de passe vide précédemment).
- Entrer le nom de l'utilisateur courant. Ce sera l'utilisateur principal du serveur auquel vous vous connecterez en SSH.
- Entrer l'identifiant de l'utilisateur courant. Je recommande de mettre le même que le nom de l'utilisateur.
- Entrer le mot de passe de l'utilisateur courant. Je recommande de mettre un mot de passe fort.
- Confirmer le mot de passe.
- SÉlectionner le partitionnement du disque dur. Si tous les données du disque dur peuvent être effacées, je recommande de sélectionner `Assisté - utiliser un disque entier` pour une installation simple.
- Sélectionner le disque dur à utiliser. **Attention** à ne pas sélectionner votre clé USB bootable.
- Sélectionner le schéma de partitionnement. Je recommande de sélectionner `Tous les fichiers dans une seule partition` pour une installation simple.
- Sélectionner `Terminer le partitionnement et appliquer les changements`. **Attention**, Cette étape effacera toutes les données présentes sur le disque dur sélectionné.
- Confirmer l'application des changements sur le disque dur.
- Sélectionner `oui` si vous voulez utiliser un miroir réseau pour installer des paquets supplémentaires.
- Selectionner le pays pour le miroir des paquets.
- Selectionner le miroir des paquets `deb.debian.org`.
- Entrer le proxy (laisser vide si vous n'en avez pas).
- Selectionner si vous voulez participer à l'envoi de données anonymes.
- Selectionner les paquets à installer.
    - Serveur SSH
    - utilitaires usuels du système
- Appuyer sur `tab` pour sélectionner le bouton `Continuer`, puis appuyer sur `Entrée`.
- Installer le programme de démarrage GRUB. (Si vous avez déjà GRUB, il ne vous sera pas demandé de l'installer)
- Sélectionner le disque dur où installer GRUB. Généralement le même que celui où vous avez installé Debian. **Attention** à ne pas sélectionner votre clé USB bootable.
- Vous avez terminé l'installation de Debian.
- Si vous y êtes invité, retirer la clé USB bootable.
- Cliquer sur `continuer` pour redémarrer l'ordinateur.
- Cliquer sur `Debian/GNU` pour démarrer l'ordinateur sur le système installé.
- Entrer le nom d'utilisateur créé précédemment.
- Entrer le mot de passe.

Vous avez maintenant un serveur Debian fonctionnel sur lequel vous êtes connecté en tant qu'utilisateur courant.

## Configuration de l'adresse IP fixe

Vous pouvez configurer une adresse IP fixe pour votre serveur afin de faciliter son accès en réseau local.

Vous pouvez faire cette étape plus tard mais il est recommandé de la faire maintenant pour éviter d'avoir à reconfigurer des services plus tard.

Cette partie va se faire sur le panel administrateur de votre routeur / box internet.

- Accéder à l'interface d'administration de votre routeur / box internet
    - adresse IP courante de votre routeur

    ```txt
    192.168.1.1
    192.168.0.1
    192.168.1.254
    ```

- Accéder aux paramètres avancés.
- Accéder à la section de configuration du DHCP IPv4 (Dynamic Host Configuration Protocol version 4).
- Accéder à la section de `Attribution d'adresse IP statique` ou `Réservation d'adresse IP`.
- Ajouter une nouvelle réservation d'adresse IP.
- Sélectionner l'appareil correspondant à votre serveur (généralement identifié par son nom (nom de la machine lors de l'installation de l'OS)).
- Entrer l'adresse IP fixe que vous souhaitez attribuer à votre serveur (par exemple `192.168.1.200`).
    - /!\ Attention, éviter les adresses IP qui sont dans la plage DHCP de votre routeur (généralement entre `192.168.1.1` et `192.168.1.199`). Préférer une adresse IP en dehors de cette plage (par exemple `192.168.1.200`).
- Les autres champs (masque de sous-réseau, passerelle, DNS, adresse mac, etc) devraient se remplir automatiquement avec les bonnes valeurs.
- Sauvegarder la réservation d'adresse IP.
- Il peut être nécessaire de redémarrer le serveur pour que l'adresse IP fixe soit prise en compte.

## Installation et configuration des dépendances de base

Vous avez maintenant un serveur Debian fonctionnel sur lequel vous êtes connecté en tant qu'utilisateur courant.

### Sudo

nous allons maintenant installer et configurer `sudo` pour permettre à l'utilisateur courant d'exécuter des commandes avec les privilèges administrateur.

Si vous n'avez pas défini de mot de passe pour l'utilisateur `root` lors de l'installation de Debian, `sudo` est déjà installé et configuré pour l'utilisateur courant. Vous pouvez vérifier cela en essayant d'exécuter une commande `sudo date`. Si cela fonctionne, vous pouvez passer directement à la section [SSH](#ssh).

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

### SSH

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
- Tous ce qui suit va être fait sur le serveur (vous serez physiquement sur votre ordinateur mais vous serez connecté en SSH à votre serveur, les instructions suivantes seront donc exécutées sur le serveur. attention, ne vous trompez pas de terminal).
- Créer le dossier `.ssh` dans le dossier de l'utilisateur.

    ```bash
    mkdir -m 700  ~/.ssh
    ```

- Créer le fichier `authorized_keys` dans le dossier `.ssh`.

    ```bash
    touch ~/.ssh/authorized_keys
    ```

- Modifier les permissions du fichier `authorized_keys`.

    ```bash
    chmod 600 ~/.ssh/authorized_keys
    ```

- Copier la clé publique de votre ordinateur précédemment générée dans le fichier `authorized_keys`.
- Modifier la ligne `PasswordAuthentication` pour qu'elle soit égale à `no` (cela désactive l'authentification par mot de passe, vous devrez utiliser une clé SSH pour vous connecter).

    ```txt
    # This is the sshd server system-wide configuration file.  See
    # sshd_config(5) for more information.

    ...
    PasswordAuthentication no
    ...
    ```

- Redémarrer le service SSH.

    ```bash
    sudo service ssh restart
    ```

Plus d'informations sur la configuration de SSH sont disponibles dans la documentation dédiée à [SSH](../../02_applications/ssh.md)

Vous avez maintenant un serveur Debian fonctionnel avec `sudo` et SSH configurés correctement et de manière sécurisée. Seul l'utilisateur courant peut se connecter en SSH en utilisant la clé SSH précédemment générée. Dans les fait cela veux dire que seul quelqu'un possédant la clé privée correspondante à la clé publique présente dans le fichier `authorized_keys` pourra se connecter en SSH et que même si cette clé est compromise, l'utilisateur `root` ne pourra jamais être utilisé et que toutes les commandes nécessitant des privilèges administrateur devront être exécutées via `sudo` qui nécessite la saisie du mot de passe de l'utilisateur qui n'est enregistrer nul part.

#### Connexion à distance via SSH

Pour plus d'informations sur l'installation et l'utilisation de SSH, vous pouvez consulter la documentation dédiée à [SSH](../../02_applications/ssh.md)

- Connectez-vous au serveur en SSH depuis un autre ordinateur connecté au même réseau local.

    ```bash
    ssh <nom_utilisateur>@<adresse_ip> -p <port>
    ```

    - Remplacer `<nom_utilisateur>` par le nom d'utilisateur créé lors de l'installation de Debian.
    - Remplacer `<adresse_ip>` par l'adresse IP fixe configurée précédemment ou l'adresse IP actuelle du serveur.
    - Remplacer `<port>` par le numéro de port configuré précédemment pour SSH.
    - Entrer la passphrase de la clé SSH si vous en avez mis une.

### Git

- Installer Git.

    ```bash
    sudo apt update && sudo apt install git
    ```

Plus d'informations sur l'installation et l'utilisation de Git sont disponibles dans la documentation dédiée à [Git](../../02_applications/git.md)

## Configuration supplémentaire (optionnelle)

Vous avez maintenant un serveur Debian fonctionnel, bien protégé et accessible à distance via SSH. Mais pour l'instant il n'a pas encore de fonctionnalités spécifiques.

Dans cette section, nous allons voir comment installer et configurer des services supplémentaires pour rendre votre serveur plus utile.

### Installation et configuration de Docker et Docker Compose

Docker est une plateforme de conteneurisation qui permet de créer, déployer et exécuter des applications dans des conteneurs légers et portables. Docker Compose est un outil qui permet de définir et de gérer des applications multi-conteneurs Docker. Voici comment les installer et les configurer sur votre serveur Debian.

Pour installer Docker engine, vous pouvez suivre la [documentation d'installation de Docker engine](../../02_applications/docker_installation.md)

### Installation et configuration de Prometheus

Prometheus est un système de surveillance et d'alerte open-source conçu pour collecter et stocker des métriques en temps réel. Voici comment l'installer et le configurer sur votre serveur Debian.

### Installation et configuration de Grafana

Grafana est une plateforme open-source de visualisation et d'analyse de données qui permet de créer des tableaux de bord interactifs. Voici comment l'installer et le configurer sur votre serveur Debian.

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
