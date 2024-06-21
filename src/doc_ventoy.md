# Documentation de Ventoy

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

- [Documentation de Ventoy](#documentation-de-ventoy)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Description de Ventoy](#description-de-ventoy)
  - [Installation de Ventoy (Multi-boot USB) - Linux](#installation-de-ventoy-multi-boot-usb---linux)
  - [Créer une clé bootable avec Ventoy](#créer-une-clé-bootable-avec-ventoy)
  - [Ajouter des ISO dans la clé USB bootable préalablement créée avec Ventoy](#ajouter-des-iso-dans-la-clé-usb-bootable-préalablement-créée-avec-ventoy)
  - [Démarrer un ordinateur sur une clé USB bootable créée avec Ventoy](#démarrer-un-ordinateur-sur-une-clé-usb-bootable-créée-avec-ventoy)

<div class="page"></div>

## Description de Ventoy

Ventoy est un utilitaire qui permet de créer une clé USB multi-boot. Il suffit de copier les fichiers ISO sur la clé USB et Ventoy les détectera automatiquement.

## Installation de Ventoy (Multi-boot USB) - Linux

- Télécharger le fichier tar.gz de la dernière version Ventoy sur le site officiel :

  > <https://github.com/ventoy/Ventoy/releases/download/>< version >/ventoy-< version >-linux.tar.gz

- Placer vous dans le dossier de téléchargement où le fichier `ventoy-<version>-linux.tar.gz` à été installé :

  ```shell
  cd ~/Téléchargements
  ```

- Déplacer le fichier tar.gz dans le dossier de votre choix, pour moi ce sera `/opt` :

  ```shell
  sudo mv ventoy-<version>-linux.tar.gz /opt/
  ```

- Placer vous dans le dossier `/opt` :

  ```shell
  cd /opt
  ```

- Extraire le fichier tar.gz :

  ```shell
  tar -xvf ventoy-<version>-linux.tar.gz
  ```

- Supprimer le fichier tar.gz :

  ```shell
  sudo rm ventoy-<version>-linux.tar.gz`
  ```

## Créer une clé bootable avec Ventoy

- Brancher la clé USB
- Ouvrez le gestionnaire de fichier
- Placer vous dans le dossier `/opt/ventoy-<version>/`
- Activez les droits d'exécution du logiciel : clic droit sur '`VentoyGUI.x86_64`' > '`propriété`' > '`Permissions`' > cochez '`Autoriser l'exécution du fichier comme un programme`'
- Lancer le logiciel en mode GUI : Double cliquer sur le fichier `VentoyGUI.x86_64`

  !["Image du GUI de Ventoy abscente"](../Images/ventoy_gui.png "Image du GUI de Ventoy")

- Si l'anglais ne vous cinvient pas allez dans le menu '`Language`' puis choisir la langue qui vous convient
- Sélectionner la clé USB dans la liste déroulante '`Périphérique`'
- Cliquer sur le bouton '`Installer`'
- Une fois l'installation terminée, fermer la fenêtre

## Ajouter des ISO dans la clé USB bootable préalablement créée avec Ventoy

- Télécharger les ISO de votre choix.
  - Lien pour télécharger les ISO de Ubuntu desktop :
    > <https://www.ubuntu-fr.org/download/>
  - Lien pour télécharger les ISO de Ubuntu server  :
    > <https://ubuntu.com/download/server>

- Placer vous dans la racine de votre clé USB :

  ```shell
  cd /media/${USER}/<nom_de_la_cle_USB>
  ```

- Créer un dossier pour chaque ISO :

  ```shell
  mkdir <nom_du_dossier>
  ```

- Copier et synchroniser l'ISO dans le dossier :
  - Cette opération prend plusieurs minutes

  ```shell
  cp -v ~/Téléchargements/<nom_du_fichier_ISO> <nom_du_dossier>/ && sync
  ```

## Démarrer un ordinateur sur une clé USB bootable créée avec Ventoy

- Brancher la clé USB sur un ordianateur éteint
- Démarrer l'ordinateur
- Quand le logo du constructeur apparait, appuyer sur la touche `F2` (ou `F12` selon les constructeurs) pour accéder au BIOS.
- Dans le BIOS, aller dans l'onglet '`Boot`' ou '`Boot Configuration`'
**Attention l'ordre et le nom de ces option peuvent varié en fonction du constructeur de votre PC mais la logique reste la même donc vous pouvez quand même vous appuyer sur cette documentation**
- Sélectionner '`Add New Boot Option`'
- Sélectionner '`Add boot option`'
- Entrer le nom que vous voulez, dans mon cas "`cle usb`"
- Sélectionner '`Path for boot option`'
- Sélectionner la partition qui correspond à votre clé USB, dans mon cas `PCI(10|0)\USB(2,0)\HD(Part2,Sig5FA02450)`
**A partir d'ici il ne devrai plus y avoir de différence**
- Sélectionner le fichier `/EFI/BOOT/grub.efi`.
- Choisissez si vous voulez activé le '`Secure Boot`', dans mon cas je le laisse désactivé pour éviter des potentiel erreur de compatibilité avec Debian 12.
- Sélectionner le mode de Secure Boot  entre '`Deployed Mode`' et '`Audit Mode`', dans mon cas j'ai laisser par défaut, c'est à dire '`Deployed Mode`'.
- Pour toute les question de '`Key Management`' j'ai laisser les options par défaut.
- Sélectionner '`Create`' ou '`Add Boot Option`'
- Mettre la clé USB en premier dans la liste des périphériques de démarrage.
- Sauvegarder les modifications en appuyant sur '`APPLY CHANGES`'
- Quitter le BIOS en appuyant sur '`EXIT`'.

<br />

- L'ordinateur vas redémarrer et vous allez arriver sur le menu de démarrage de Ventoy
- Sélectionner l'ISO que vous voulez démarrer
- Sélectionner le mode de démarrage, dans mon cas : '`Boot in normal mode`'
- Suiver les instructions d'installation de l'OS
