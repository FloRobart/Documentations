# Documentation KeePass

## Table des matières

- [Documentation KeePass](#documentation-keepass)
    - [Table des matières](#table-des-matières)
    - [Sources](#sources)
    - [Introduction](#introduction)
    - [Présentation de l'éco-systeme KeePass](#présentation-de-léco-systeme-keepass)
    - [KeePassXC](#keepassxc)
        - [Installation de KeePassXC](#installation-de-keepassxc)
        - [Utilisation de KeePassXC](#utilisation-de-keepassxc)
    - [Syncthing](#syncthing)
        - [Installation sur un ordinateur sous Linux (Debian/Ubuntu)](#installation-sur-un-ordinateur-sous-linux-debianubuntu)
        - [Installation sur un téléphone (Android)](#installation-sur-un-téléphone-android)
        - [Utilisation de Syncthing](#utilisation-de-syncthing)
    - [KeePassDX](#keepassdx)
    - [KeePassXC-Browser](#keepassxc-browser)
    - [Licence](#licence)

## Sources

- [Site officiel de KeePass](https://keepass.info/)
- [Site officiel de KeePassXC](https://keepassxc.org/)
- [Site officiel de KeePassDX](https://keepassdx.com/)
- [Site officiel de Syncthing](https://syncthing.net/)
- [Page d'extension Firefox pour KeePassXC-Browser](https://addons.mozilla.org/fr/firefox/addon/keepassxc-browser/)

## Introduction

Dans ce tutoriel, nous allons vous montrer comment installer KeePass sur PC (Linux) et Téléphone (Android), faire la synchronisation automatique de vos mots de passe entre les deux appareils ainsi que d'installer l'extension KeePass pour navigateur web.

## Présentation de l'éco-systeme KeePass

KeePass est un système de gestion de mots de passe open source qui permet aux utilisateurs de stocker et de gérer leurs mots de passe de manière sécurisée et 100% locale. KeePass utilise un fichier de base de données chiffré pour stocker les informations d'identification, ce qui garantit que vos mots de passe restent privés et protégés contre les accès non autorisés.

Pour accéder à vos mots de passe, vous devez utiliser un client KeePass. Le principe c'est KeePass représente la façon de stocker vos mots de passe dans un fichier chiffré unique (avec l'extension .kdbx). Il existe dans plusieurs clients KeePass pour différents systèmes d'exploitation et plateformes, chacun offrant des interfaces utilisateur différentes.

Je vous laisse le soin de découvrir les différents clients KeePass disponibles pour votre système d'exploitation préféré.

Voici les clients KeePass qui seront utilisés dans ce tutoriel :

- **KeePassXC** : Client open source pour Linux, Windows et MacOS. Ce n'est pas le plus beau mais il est très fonctionnel, facile à utiliser, offre une très bonne compatibilité et est une référence dans le monde de KeePass.
- **KeePassDX** : Client open source pour Android.
- **KeePassXC-Browser** : Extension open source pour navigateur web (Firefox, Chrome, Edge, Brave, Vivaldi, etc.) qui permet d'accéder à vos mots de passe directement depuis votre navigateur web.
- **Syncthing** : Logiciel open source pour synchroniser vos fichiers/dossiers entre vos appareils (PC, téléphone, etc.) de manière sécurisée et sans passer par un serveur centralisé. Nous allons l'utiliser pour synchroniser votre fichier de base de données KeePass entre votre PC et votre téléphone.

Grâce à cette combinaison de clients KeePass et de Syncthing, vous pourrez gérer vos mots de passe de manière sécurisée et efficace sur tous vos appareils, tout en gardant le contrôle total sur vos données, sans jamais passer par un serveur centralisé. Vous pourrez ainsi accéder à vos mots de passe où que vous soyez, tout en garantissant leur sécurité et leur confidentialité.

## KeePassXC

Je recommande d'installer KeePassXC via le gestionnaire de paquets APT. Si vous voulez l'intaller via un autre moyen, vous pouvez regarder la [documentation officiel de KeePassXC](https://keepassxc.org/download/#linux).

### Installation de KeePassXC

- Ajouter le dépôt officiel de KeePassXC à votre liste de sources APT :

```bash
sudo add-apt-repository ppa:phoerious/keepassxc
```

- Mettre à jour la liste des paquets disponibles :

```bash
sudo apt update
```

- Installer KeePassXC :

```bash
sudo apt install keepassxc
```

### Utilisation de KeePassXC

- Lancer KeePassXC
- Cliquer sur `Créer une base de données`
- Entrer un nom et une description pour votre base de données
- Modifier si vous le souhaitez le `Temps de déchiffrement` à votre convenance (par défaut 1 seconde)
- Cliquer sur `Suivant`
- Entrer un mot de passe fort pour protéger votre base de données et cliquer sur `Suivant`
- Sélectionner un emplacement pour enregistrer votre base de données, par exemple le dossier `~/Documents/KeePass/`
- Cliquer sur `Terminer` pour créer votre base de données KeePass
- Votre base de données est maintenant créée, vous pouvez commencer à ajouter vos mots de passe et autres informations d'identification.

## Syncthing

Syncthing est un logiciel open source de synchronisation de fichiers. Il permet de synchroniser vos fichiers et dossiers entre vos appareils de manière sécurisée et sans passer par un serveur centralisé.

Pour les détails techniques, Syncthing utilise un protocole de communication peer-to-peer pour synchroniser les fichiers entre les appareils. Cela signifie que vos fichiers ne sont jamais stockés sur un serveur centralisé, mais sont directement transférés entre vos appareils via un réseau local.

### Installation sur un ordinateur sous Linux (Debian/Ubuntu)

- Installer Syncthing sur votre PC (Linux)

```bash
sudo apt install syncthing
```

- Lancer le service Syncthing sur votre PC (Linux)

```bash
systemctl --user enable --now syncthing.service
```

### Installation sur un téléphone (Android)

- Télécharger l'application `Syncthing-Fork` (`com.github.catfriend1.syncthingandroid`) Syncthing depuis `F-Droid` ou `Google Play Store`
- Lancer l'application `Syncthing-Fork` sur votre téléphone (Android) et suivre les instructions de l'application pour initialiser l'application et créer un identifiant unique pour votre appareil.

### Utilisation de Syncthing

- Lancer l'interface web de Syncthing sur votre PC (Linux)

```bash
xdg-open http://localhost:8384
```

- {*PC*} Cliquer sur `Ajouter un appareil` en bas à droite de l'interface web de Syncthing sur votre PC
- {*Téléphone*} Cliquer sur le menu burger (trois lignes horizontales) en haut à gauche de l'application
- {*Téléphone*} Cliquer sur `Afficher l'ID de l'appareil` et copier l'ID de votre appareil
- {*PC*} Coller l'ID de votre appareil dans le champ `ID de l'appareil`
- {*PC*} Entrer un nom pour votre appareil, par exemple le modèle de votre téléphone
- *Optionnel*
    - {*PC*} Aller dans l'onglet `Avancée`
    - {*PC*} Cliquer sur `Retirer la confiance` pour chiffrer les communications entre vos appareils
- {*PC*} Cliquer sur `Ajouter un appareil`
- {*Téléphone*} Une notification apparaîtra sur votre téléphone pour accepter la demande de connexion de votre PC, cliquer sur `Accepter`. Attention, la notification peut être silencieuse, il faut donc vérifier dans la liste des notifications si vous n'avez pas vu la notification.
- {*PC*} Cliquer sur `Ajouter un partage`
- {*PC*} Entrer un nom pour votre partage, par exemple `KeePass`
- {*PC*} Entrer le chemin du dossier à synchroniser, par exemple le dossier où se trouve votre fichier de base de données KeePass (par exemple `~/Documents/KeePass/`)
- {*PC*} Aller dans l'onglet `Partages`
- {*PC*} Selectionner votre appareil (votre téléphone) dans la liste des appareils disponibles pour le partage
- {*PC*} Aller dans l'onglet `Préservation des fichiers`
- {*PC*} Sélectionner l'option `Suivi simplifié des versions`
- {*PC*} Définir le temps de conservation des versions à 30 jours (ou plus si vous le souhaitez)
- {*PC*} Cliquer sur `Enrgistrer` pour créer le partage
- {*Téléphone*} Une notification apparaîtra sur votre téléphone pour accepter le partage de votre PC, cliquer sur `Accepter`. Attention, la notification peut être silencieuse, il faut donc vérifier dans la liste des notifications si vous n'avez pas vu la notification.
- {*Téléphone*} Selectionner le dossier de destination pour synchroniser les fichiers, par exemple le dossier `KeePass` dans le stockage interne de votre téléphone.
- {*Téléphone*} Cliquer sur `Enregistrer` pour créer le partage
- Votre fichier de base de données KeePass est maintenant synchronisé entre votre PC et votre téléphone. Vous pouvez maintenant accéder à vos mots de passe depuis votre téléphone en utilisant l'application KeePassDX.

## KeePassDX

- Ouvrer l'application `KeePassDX` sur votre téléphone (Android)
- Cliquer sur `Ouvrir un coffre-fort existant`
- Naviguer vers le dossier où se trouve votre fichier de base de données KeePass synchronisé par Syncthing (par exemple le dossier `KeePass` dans le stockage interne de votre téléphone)
- Sélectionner votre fichier de base de données KeePass (par exemple `mon_carnet_de_mots_de_passe.kdbx`)
- Entrer le mot de passe que vous avez défini lors de la création de votre base de données KeePass sur votre PC
- Cliquer sur `Déverrouiller` en bas à gauche (pas à droite) de votre écran pour accéder à vos mots de passe ET autoriser l'ouverture de votre base de données avec l'authentification biométrique (empreinte digitale ou reconnaissance faciale) si votre téléphone le permet.

## KeePassXC-Browser

- {*PC*} Ouvrir KeePassXC et déverrouiller la base de données
- {*PC*} Aller dans le menu `Outils` > `Paramètres`
- {*PC*} Cliquer sur la section `Intégration aux navigateurs` dans le menu latéral gauche
- {*PC*} Cocher la case `Activer l'intégration aux navigateurs`
- {*PC*} Cocher la case `Firefox` dans la liste des navigateurs compatibles
- {*PC*} Cliquer sur le bouton `OK` en bas à droite pour enregistrer les modifications
- *Si Firefox est installé au format Snap (par défaut sur Ubuntu)*
    - {*PC*} Ouvrir un terminal
    - {*PC*} Exécuter la commande `mkdir -p ~/snap/firefox/common/.mozilla/native-messaging-hosts`
    - {*PC*} Exécuter la commande `ln -sf ~/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json ~/snap/firefox/common/.mozilla/native-messaging-hosts/`
- {*PC*} Fermer complètement Firefox puis le relancer
- {*PC*} S'assurer que KeePassXC reste ouvert et déverrouillé en arrière-plan
- {*PC*} Cliquer sur l'icône de l'extension `KeePassXC-Browser` dans la barre d'outils de Firefox
- {*PC*} Cliquer sur le bouton `Connecter` dans le panneau de l'extension
- {*PC*} Une fenêtre d'association KeePassXC apparaît à l'écran, entrer un nom d'identifiant unique (par exemple `Firefox-Ubuntu`)
- {*PC*} Cliquer sur `Enregistrer et autoriser l'accès` pour finaliser l'appairage

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
