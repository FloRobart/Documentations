# Exécution de logiciel Windows sur Linux

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

- [Exécution de logiciel Windows sur Linux](#exécution-de-logiciel-windows-sur-linux)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Présentation des différentes solutions pour exécuter des logiciels Windows sur Linux](#présentation-des-différentes-solutions-pour-exécuter-des-logiciels-windows-sur-linux)
  - [Wine](#wine)
    - [Installation de Wine - Linux](#installation-de-wine---linux)
    - [configurer de Wine comme programme par défaut pour charger les applications Windows](#configurer-de-wine-comme-programme-par-défaut-pour-charger-les-applications-windows)
  - [Proton](#proton)
  - [PlayOnLinux](#playonlinux)
  - [Lutris](#lutris)
  - [Installation de League of Legends à l'aide de Lutris - Linux](#installation-de-league-of-legends-à-laide-de-lutris---linux)
    - [Prérequit](#prérequit)
    - [Installation de Wine](#installation-de-wine)
      - [Utilisation d'applications Windows sur Ubuntu grâce à Wine](#utilisation-dapplications-windows-sur-ubuntu-grâce-à-wine)
    - [Installtion de Lutris](#installtion-de-lutris)

<div class="page"></div>

## Présentation des différentes solutions pour exécuter des logiciels Windows sur Linux

Pour exécuter des logiciels Windows sur Linux il existe plusieurs solutions

- Wine
- Lutris
- Proton
- PlayOnLinux

## Wine

Wine est un logiciel qui permet de traduire les appels systèmes de Windows en appels systèmes POSIX, permettant ainsi d'exécuter des applications Windows sous Linux.

Il est fortement recommandé parce qu'il est très efficace, stable et permet d'exécuter des logiciels Windows et pas uniquement des jeux. Il est plus difficile à configurer que Proton mais il est plus stable et permet d'exécuter des logiciels non Steam de façon plus sure.

### Installation de Wine - Linux

- Installer le paquet `wine` depuis le dépot `apt`

  ```shell
  sudo apt install wine
  ```

- Installer le paquet `wine32` depuis le dépot `apt` ainsi que l'architecture 32 bits `i386`
  - Ce paquet est nécessaire pour le bon fonctionnement de wine, même si vous avez un système 64 bits et n'utiliser que des applications 64 bits

  ```shell
  sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install wine32:i386
  ```

- Tester le bon fonctionnement de wine en installant le logiciel `notepad++` :
  - Télécharger le fichier d'installation de notepad++

    ```shell
    wget https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8/npp.8.0.Installer.x64.exe
    ```

  - Installer notepad++ avec wine

    ```shell
    wine npp.8.0.Installer.x64.exe
    ```

  - Suiver les instructions d'installation de notepad++
  - Créer un raccourci de notepad++ sur le bureau
  - Pour que le raccourci fonctionne, il faut faire clique droit dessus > '`Autoriser l'exécution`'

### configurer de Wine comme programme par défaut pour charger les applications Windows

- Créer un lien symbolique de `wine.desktop` dans le dossier `/usr/share/applications` :

  ```shell
  sudo ln -s /usr/share/doc/wine/examples/wine.desktop /usr/share/applications
  ```

- Faite un clique droit sur l'application Windows que vous voulez lancer > Ouvrir avec > Autre application > Wine - Chargeur de programmes Windows
  - Penser à bien cocher la case '`Toujours utiliser pour ce type de fichier`'
- Vous pouvez maintenant lancer l'application Windows en double cliquant dessus

## Proton

Proton est un outil de compatibilité pour exécuter des jeux Windows sur Linux via Steam. Proton est développé par Valve et basé sur Wine et d'autres composants.

Proton est très efficace et stable mais permet uniquement d'exécuter des jeux Steam. Il est tout de même possible d'exécuter des jeux non Steam avec Proton Expérimental mais cela n'est pas recommandé car c'est encore en développement et ne fonctionne pas toujours.

## PlayOnLinux

PlayOnLinux est un logiciel qui permet d'installer et d'utiliser facilement de nombreux jeux et logiciels conçus pour fonctionner exclusivement sous Windows.

## Lutris

Lutris est une plate-forme de jeu open source pour Linux. Il est conçu pour gérer l’installation et la configuration des jeux et pour fournir une interface unifiée pour jouer à des jeux à partir de plusieurs sources.

Lutris peut gérer des jeux provenant de diverses sources, notamment Steam, GOG et Humble Bundle. Il peut également gérer les installations de jeux personnalisées, par exemple à partir d'un fichier ISO.

## Installation de League of Legends à l'aide de Lutris - Linux

**L'installation de League of Legends à l'aide de Lutris n'a pas fonctionné pour moi, j'ai donc fini pas abandonner l'idée de jouer à League of Legends sur Linux**

- Installer lutris
- Installer wine
- Installer winetricks
- suivre les instructions d'installation de lutris
- Erreur, impossible de lancer le fichier `explorer.exe`

### Prérequit

- Avoir les droits d'administration
- Vous n'avez même pas besoin d'installer Wine, Lutris s'en charge pour vous

### Installation de Wine

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install wine
  ```

#### Utilisation d'applications Windows sur Ubuntu grâce à Wine

- Installer et configurer `Wine`
- Installer l'exécutable de l'application Windows
- Lancer l'exécutable avec `Wine`

  ```shell
  wine <nom_du_fichier>.exe
  ```

- Vous pouvez maintenant utiliser l'application Windows sur Ubuntu

### Installtion de Lutris

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install lutris
  ```

- Ouvrez Lutris
- Cliquer sur le bouton '`+`' en haut à gauche de la fenêtre
- Cliquer sur '`Rechercher des installateurs sur le site de Lutris`'
- Chercher "`League of Legends`"
- Cliquer sur '`League of Legends`' avec en dessous '`2009, Mac, Windows`'
- Cliquer sur '`Installer`'
- Cliquer sur '`Continuer`'
- Patienter pendant l'installation, cela peut prendre beaucoup de temps

- OSerror

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
