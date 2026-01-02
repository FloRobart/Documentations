# Création d'un dual boot Debian 12 KDE Plasma (avec Windows 11 déjà installé)

## Table des matières

- [Création d'un dual boot Debian 12 KDE Plasma (avec Windows 11 déjà installé)](#création-dun-dual-boot-debian-12-kde-plasma-avec-windows-11-déjà-installé)
    - [Table des matières](#table-des-matières)
    - [Installation de Debian 12 KDE Plasma](#installation-de-debian-12-kde-plasma)
        - [Si vous pouvez redimensionner la partition Linux](#si-vous-pouvez-redimensionner-la-partition-linux)
        - [Si vous ne pouvez pas redimensionner la partition Linux](#si-vous-ne-pouvez-pas-redimensionner-la-partition-linux)
        - [Configuration de la partition SWAP](#configuration-de-la-partition-swap)
        - [Suite de la configuration du partitionnement](#suite-de-la-configuration-du-partitionnement)
    - [Configuration de KDE Plasma pour ressembler à Ubuntu desktop](#configuration-de-kde-plasma-pour-ressembler-à-ubuntu-desktop)
    - [Licence](#licence)

## Installation de Debian 12 KDE Plasma

- Sélectionner le mode d'installation, dans mon cas j'ai sélectionner '`Graphics install`' mais '`Install`' est exactement la même chose en moins jolie.
- Sélectionner la langue, dans mon cas '`French - Français`'
- Sélectionner la situation géographique, dans mon cas '`France`'
- Sélectionner la configuration du clavier, dans mon cas '`Français`'
- Connecter votre ordinateur à un point d'accès wifi
    - Si vous faite un partage de connexion avec votre téléphone, il faut configurer le point d'accès pour qu'il communique avec le protocole de sécurité WPA2-Personal, Attention le protocole WPA3 n'est pas encore supporté par Debian 12 et si votre partage de connexion est en WPA2/WPA3-Personal vous ne pourrez pas vous connecter à internet.
- Configuration du nom de la machine sur le réseau, dans mon cas "`Dell-inspiron-Debian`"
- Configuration du nom de domaine, dans mon cas j'ai laissé le champ vide
- Configuration du mot de passe du super utilisateur `root`
- Création d'un utilisateur, dans mon cas :
    - Nom complet : "`Floris Robart`"
    - Identifiant pour le compte utilisateur : "`floris`"
    - Mot de passe
    - Confirmer le mot de passe
- Choisissez le partitionnement du disque, dans mon cas '`Manuel`'

### Si vous pouvez redimensionner la partition Linux

**Si vous ne pouvez pas redimensionner la partition Linux, aller à la section suivante**

- Sélectionner la partition sur lequel vous voulez installer Debian 12, dans mon cas se sera la partition '` > n°5 169.2 GB ext4`' présent sur le disque dur '`/dev/nvme0n1 - 512.1 GB KBG40ZNS512G NVMe KIOXIA 512GB`'
- Sélectionner l'action à réaliser sur la partition, dans mon cas j'ai sélectionner '`Effacer les données de cette partition`'
- Confirmer l'action que vous voulez effectuer sur la partition en sélectionnant '`Oui`'. **Attention les changement supprimeront toutes les données présente sur la partition de façon irréversible**
- Attendre que toute les données de la partition soit effacé, cela peux prendre plusieurs minutes voir plusieurs heures en fonction de la taille de la partition, du nombre de données présent sur la partition et de la vitesse de votre disque dur
- Entrer un nom pour la partition, dans mon cas "`Debian 12`"
- Indiquer L'usage (`Utiliser comme :`) de la partition, dans mon cas j'ai sélectionner '`système de fichiers journalisé ext4`'
- Indiquer si vous voulez formatter la partition, dans mon cas j'ai sélectionner '`Oui, formater`'
- Sélectionner le point de montage de la partition, dans mon cas j'ai sélectionner '`/`'
- Laisser l'option de montage par défaut, dans mon cas j'ai laissé '`defaults`'
- Vous pouvez mettre une étiquette sur la partition, dans mon cas j'ai laissé par défaut, c'est à dire '`aucune`'
- Laisser le blocs réservés par défaut, dans mon cas j'ai laissé '`5%`'
- Laisser l'utilisation habituelle de la partition par défaut, dans mon cas j'ai laissé '`standard`'
- Laisser l'indicateur d'amorçage par défaut, dans mon cas j'ai laissé '`absent`' mais vous pouvez essayer de cliquer dessus, dans mon cas cela ne change rien mais peut être que dans votre cas cela changera quelque chose
- Sélectionner '`Fin de paramétrage de cette partition`' pour revenir au menu de sélection des partitions
    - vous pouvez en profiter pour faire d'autre action sur d'autre partition si vous le souhaitez mais se n'est pas mon cas
- Configuration d'une partition d'échange (SWAP). Le swap est le prolongement de la RAM sur le disque dur, le plus souvent on choisira une taille de swap qui fait le double de celle de la RAM. Dans mon cas j'ai 16GB de RAM donc je vais mettre 19.2GB de swap pour que ma partition Debian fasse 150GB
    - Je ne peux pas redimensionner la partition donc je l'ai supprimer

### Si vous ne pouvez pas redimensionner la partition Linux

**Si vous avez pu redimensionner la partition Linux en suivant les instructions précédente, aller à la section suivante**

- Sélectionner la partition sur lequel vous voulez installer Debian 12, dans mon cas se sera la partition '` >  169.2 GB Espace libre`' présent sur le disque dur '`/dev/nvme0n1 - 512.1 GB KBG40ZNS512G NVMe KIOXIA 512GB`'
- Sélectionner '`Créer une nouvelle partition`'
- Sélectionner la taille de la partition, dans mon cas j'ai sélectionner '`150 GB`'
- Sélectionner '`Début`'
- Entrer un nom pour la partition, dans mon cas "`Debian 12`"
- Indiquer L'usage (`Utiliser comme :`) de la partition, dans mon cas j'ai sélectionner '`système de fichiers journalisé ext4`'
- Indiquer si vous voulez formatter la partition, dans mon cas j'ai sélectionner '`Oui, formater`'
- Sélectionner le point de montage de la partition, dans mon cas j'ai sélectionner '`/`'
- Laisser l'option de montage par défaut, dans mon cas j'ai laissé '`defaults`'
- Vous pouvez mettre une étiquette sur la partition, dans mon cas j'ai laissé par défaut, c'est à dire '`aucune`'
- Laisser le blocs réservés par défaut, dans mon cas j'ai laissé '`5%`'
- Laisser l'utilisation habituelle de la partition par défaut, dans mon cas j'ai laissé '`standard`'
- Laisser l'indicateur d'amorçage par défaut, dans mon cas j'ai laissé '`absent`' mais vous pouvez essayer de cliquer dessus, dans mon cas cela ne change rien mais peut être que dans votre cas cela changera quelque chose
- Sélectionner '`Fin de paramétrage de cette partition`' pour revenir au menu de sélection des partitions

### Configuration de la partition SWAP

- Configuration d'une partition d'échange (SWAP). Le swap est le prolongement de la RAM sur le disque dur, le plus souvent on choisira une taille de swap qui fait le double de celle de la RAM. Dans mon cas j'ai 16GB de RAM donc je vais mettre 19.2GB de swap pour que ma partition Debian fasse 150GB
    - Sélectionner la partition sur lequel vous voulez installer le SWAP de Debian 12, dans mon cas se sera la partition '` >  19.2 GB Espace libre`' présent sur le disque dur '`/dev/nvme0n1 - 512.1 GB KBG40ZNS512G NVMe KIOXIA 512GB`'
    - Sélectionner '`Créer une nouvelle partition`'
    - Laisser la taille maximum qui est entré par défaut, dans mon cas j'ai laissé '`19.2 GB`'
    - Entrer un nom pour la partition, dans mon cas "`swap debian 12`"
    - Indiquer L'usage (`Utiliser comme :`) de la partition, dans mon cas j'ai sélectionner '`esâce d'échange (<< swap >>)`'
    - Laisser l'indicateur d'amorçage par défaut, dans mon cas j'ai laissé '`absent`' mais vous pouvez essayer de cliquer dessus, dans mon cas cela ne change rien mais peut être que dans votre cas cela changera quelque chose
    - Sélectionner '`Fin de paramétrage de cette partition`' pour revenir au menu de sélection des partitions

### Suite de la configuration du partitionnement

- Sélectionner '`Terminer le partitionnement et appliquer les changements`' pour revenir au menu de sélection du partitionnement
- **Vérifier bien que vous avez sélectionner les bonnes partitions avant de valider**
- Valider les changements en sélectionnant '`Oui`'
- Attendez que l'installation se termine
- Configurer l'outil de gestion de paquet en sélectionnant '`France`'
- Sélectionner le miroir de l'archive Debian, dans mon cas j'ai sélectionner '`deb.debian.org`'
- Sélectionner le mandataire HTTP à utiliser pour accéder à l'archive Debian, dans mon cas j'ai laissé vide
- Sélectionner si vous voulez participez à l'analyse des paquets installés, dans mon cas j'ai sélectionner '`Non`'
- Sélectionner l'environnement de bureau à installer, dans mon cas j'ai sélectionner '`environnement de bureau Debian`', '`KDE Plasma`' et '`utilitaires usuels du système`'
- Cliquez (avec la sourie pour l'installation graphique) sur '`Continuer`' pour lancer l'installation
- Attendez que l'installation se termine, cela peut prendre un certain temps alors soyez patient
- Retirer le support d'installation (clé USB, DVD, ...) et cliquer sur '`Continuer`'
- L'ordinateur va redémarrer
- Une fois l'ordinateur redémarrer, GRUB va se lancer et vous proposer de choisir qu'elle système lancer, sélectionner '`Debian GNU/Linux`' et appuyer sur la touche '`Entrée`' pour lancer Debian 12
- Vous pouvez vous connecter avec le compte que vous avez créer pendant l'installation
- Félicitation vous avez installer Debian 12 Mais c'est pas fini, il reste encore quelque étape à faire pour avoir un système fonctionnel
- Ajoutez votre compte utilisateur au groupe administrateur pour pouvoir utiliser la commande '`sudo`'
    - Ouvrez les paramètres de KDE Plasma
    - Cliquez sur '`Utilisateurs`'
    - Cliquez sur votre compte utilisateur
    - Passez l'élement `Type de compte` de '`Standard`' à '`Administrateur`'
    - Cliquez sur '`Appliquer`'
- Ajoutez votre compte utilisateur au groupe '`sudo`' pour pouvoir utiliser la commande '`sudo`'
    - Ouvrez un terminal (Konsole dans KDE Plasma)
    - Tapez `su root` pour passer en compte root
    - Tapez le mot de passe de votre compte root
    - Tapez `usermod -a -G sudo <nom de votre compte utilisateur>` pour ajouter votre compte utilisateur au groupe '`sudo`'
    - Tapez `sudo apt update` pour mettre à jour la liste des paquets
    - Tapez `su <nom de votre compte utilisateur>`
    - Tapez `sudo apt update` pour mettre à jour la liste des paquets. Si cette commande fonctionne alors votre compte utilisateur est bien dans le groupe '`sudo`'
    - Si quand vous lancer un nouveau terminal vous n'êtes pas dans le fichier `sudoers` et faut redémarrer votre ordinateur.

## Configuration de KDE Plasma pour ressembler à Ubuntu desktop

**A chaque fin de manipulation n'oublié pas de cliquer sur le bouton '`Appliquer`', sinon vos modifications seront perdue**

- Une fois connecter, vous allez arriver sur le bureau de KDE Plasma
- Ouvrer l'application `Configuration du système` > `Apparence` > `Thème global`
- Cliqez sur '`Breeze sombre`' pour avoir un thème sombre
- Cliquez sur le bouton '`Télécharger de nouveaux thèmes globaux...`'
- Installez le thème "`Unity-Evolution`" et "`YaruKdeDark`". Le premier ser à avoir la barre d'outils sur le coté gauche de l'écran et le deuxième ser à avoir le même tableau de bord qu'Ubuntu desktop
- Une fois les thèmes installé, sélectionner le thème '`Unity-Evolution`', Sélectionné uniquement '`Disposition de bureaux et de fenêtres`' et cliquer sur '`Appliquer`'.
- Faite un clique droit sur le bouton d'accès au tableau de bord dans la barre des tâches et sélectionner '`Afficher les alternatives...`' puis sélectionnez '`Launchpad Plasma`'
- Allez dans `Apparence` > `Couleurs` puis éditer un thème pour l'adapter à vos envis
- Allez dans `Apparence` > `Décorations de fenêtres`
- Cliquez sur le bouton avec les trois points verticaux puis sélectionner '`Obtenir de nouvelles décorations de fenêtres...`'
- Installez "`aksBorderColorAccent`". **Ce thème dégrade (pixelise) grandement le titre des fenêtres, se qui peux être dérangeant**
- Allez dans `Apparence` > `Icônes`
- Sélectionner '`YaruPlasma-Dark`'
- Allez dans `Apparence` > `Pointeurs`
- Sélectionner '`Adwaita`'
- Vous pouvez faire un clique droit sur la barre des tâches ou sur la barre d'outils (en haut de l'écran) puis cliquer sur '`Démarrer en mode d'édition`' pour modifier la barre des tâches et la barre d'outils

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
