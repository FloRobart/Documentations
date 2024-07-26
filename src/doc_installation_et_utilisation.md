# Documentation d'installation, de configuration et d'utilisation de différents logiciels

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

- [Documentation d'installation, de configuration et d'utilisation de différents logiciels](#documentation-dinstallation-de-configuration-et-dutilisation-de-différents-logiciels)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation Ventoy (Multi-boot USB) - Linux](#installation-ventoy-multi-boot-usb---linux)
  - [Installation de Chrome - Linux](#installation-de-chrome---linux)
  - [Installation de Qdirstat - Linux](#installation-de-qdirstat---linux)
  - [Installation de Ticktick - Linux](#installation-de-ticktick---linux)
  - [Installation d'android studio - Linux](#installation-dandroid-studio---linux)
  - [Installation de Netbeans - Linux](#installation-de-netbeans---linux)
  - [Installation de Postman - Linux](#installation-de-postman---linux)
  - [Installation de Trello desktop - Linux](#installation-de-trello-desktop---linux)
  - [Installation de Slack - Linux](#installation-de-slack---linux)
  - [Installation de curl - Linux](#installation-de-curl---linux)
  - [Installation de wget](#installation-de-wget)
  - [Installation de gcc - Linux](#installation-de-gcc---linux)
  - [Installation de pip - Linux](#installation-de-pip---linux)
  - [Installation de gpt-cli - Linux](#installation-de-gpt-cli---linux)
  - [Installation de CMake - Linux](#installation-de-cmake---linux)
  - [Installation de WPS Office - Linux](#installation-de-wps-office---linux)
  - [Installation de Smartmontools - Linux](#installation-de-smartmontools---linux)
  - [Installation de Flatpak (gestionnaire de paquets) - Linux](#installation-de-flatpak-gestionnaire-de-paquets---linux)
  - [Installation de Mission center - Linux](#installation-de-mission-center---linux)
  - [Installation de ZSH (interpréteur de commandes shell) - Linux](#installation-de-zsh-interpréteur-de-commandes-shell---linux)
  - [Installation du gestionnaire de packet Snap - Linux](#installation-du-gestionnaire-de-packet-snap---linux)
  - [Installation de Thunderbird - Linux](#installation-de-thunderbird---linux)
  - [Installation de FileZilla - Linux](#installation-de-filezilla---linux)
  - [Installation de TestDisk - Linux](#installation-de-testdisk---linux)
  - [Installation de Txt2man - Linux](#installation-de-txt2man---linux)
  - [Installation de neofetch - Linux](#installation-de-neofetch---linux)
  - [Installation de Scoop - Windows](#installation-de-scoop---windows)
  - [Installation de Jekyll - Linux](#installation-de-jekyll---linux)
  - [Installation de Discord - Linux](#installation-de-discord---linux)
  - [Installation de VirtualBox](#installation-de-virtualbox)
    - [Installation de VirtualBox en ajoutant le fichier deb dans le gestionnaire de paquets `apt`](#installation-de-virtualbox-en-ajoutant-le-fichier-deb-dans-le-gestionnaire-de-paquets-apt)
    - [Installation en téléchargeant le fichier deb](#installation-en-téléchargeant-le-fichier-deb)
  - [GParted](#gparted)
    - [Installation de GParted - Linux](#installation-de-gparted---linux)
    - [Allouée la partition grace à GParted - Linux](#allouée-la-partition-grace-à-gparted---linux)
  - [Dconf-Editor](#dconf-editor)
    - [Installation de Dconf-Editor - Linux](#installation-de-dconf-editor---linux)
    - [Utilisation de Dconf-Editor](#utilisation-de-dconf-editor)
      - [Modifier le comportement du dock (barre de tâche) de Gnome](#modifier-le-comportement-du-dock-barre-de-tâche-de-gnome)
  - [Pandoc](#pandoc)
    - [Description](#description)
    - [Installation de Pandoc - Linux](#installation-de-pandoc---linux)
    - [Utilisation de Pandoc](#utilisation-de-pandoc)
  - [MelonDS (émulateur de Nintendo DS) - Linux](#melonds-émulateur-de-nintendo-ds---linux)
    - [Installation de la version 0.9.1 de MelonDS](#installation-de-la-version-091-de-melonds)
    - [Configuration de MelonDS](#configuration-de-melonds)
    - [Lancer un jeu avec MelonDS](#lancer-un-jeu-avec-melonds)
    - [Améliorer les graphismes de MelonDS](#améliorer-les-graphismes-de-melonds)
    - [Configurer les touches de MelonDS](#configurer-les-touches-de-melonds)
  - [Licence](#licence)

<div class="page"></div>

## Installation Ventoy (Multi-boot USB) - Linux

[Documentation complète de Ventoy](./doc_ventoy.md)

## Installation de Chrome - Linux

- Installer le paquet deb disponible sur

  > <https://www.google.fr/chrome/>

- Executer le fichier deb

  ```shell
  sudo dpkg -i google-chrome-stable_*_amd64.deb
  ```

- Si chrome ne se lance pas, redémarrer l'ordinateur

  ```shell
  reboot
  ```

## Installation de Qdirstat - Linux

Equivalent de `Windirstat` qui permet d'analyser les disques pour savoir quel dossier et quel fichier prend le plus de place.

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install qdirstat
  ```

## Installation de Ticktick - Linux

- Installer le fichier deb disponible sur :
  > <https://ticktick.com/about/download>
- Executer le fichier deb

  ```shell
  sudo dpkg -i ticktick_*_amd64.deb
  ```

## Installation d'android studio - Linux

- Télécharger le fichier tar.gz disponible sur :
  > <https://developer.android.com/studio>

- Aller dans le dossier `/opt`

  ```shell
  cd /opt
  ```

- Déplacer le fichier tar.gz dans le dossier `/opt`

  ```shell
  sudo mv /home/floris/Téléchargements/android-studio-<version>-linux.tar.gz /opt/android-studio-<version>-linux.tar.gz
  ```

- Extraire le fichier tar.gz dans le dossier `/opt`

  ```shell
  sudo tar -xvf /opt/android-studio-<version>-linux.tar.gz
  ```

- Supprimer le fichier tar.gz

  ```shell
  sudo rm /opt/android-studio-<version>-linux.tar.gz
  ```

- Installer les bibliothèques requises pour ordinateurs 64 bits

**Uniquement pour Ubuntu 22.04 LTS (et peut être version antérieur)**

  ```shell
  sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
  ```

**Uniquement pour Fedora**

  ```shell
  sudo yum install zlib.i686 ncurses-libs.i686 bzip2-libs.i686
  ```

- Lancer Android Studio

  ```shell
  /opt/android-studio/bin/studio.sh
  ```

- Suiver les instructions d'installation

- Pour afficher Android Studio dans la liste d'applications, sélectionnez '`Tools`' > '`Create Desktop Entry`' dans la barre de menu d'Android Studio. En français : '`Outils`' > '`Créer une entrée de bureau`'

## Installation de Netbeans - Linux

- Installer le fichier deb disponible sur :
  > <https://netbeans.apache.org/download/index.html>

- Executer le fichier deb

  ```shell
  sudo dpkg -i netbeans*-bin.deb
  ```

## Installation de Postman - Linux

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install postman
  ```

## Installation de Trello desktop - Linux

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install trello-desktop
  ```

## Installation de Slack - Linux

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install slack
  ```

## Installation de curl - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install curl
  ```

## Installation de wget

wget est un utilitaire en ligne de commande pour télécharger de fichiers depuis le Web. Il supporte les protocoles HTTP, HTTPS et FTP ainsi que le téléchargement sur des serveurs HTTP à travers des proxies.

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install wget
  ```

## Installation de gcc - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install gcc
  ```

## Installation de pip - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install python3-pip
  ```

- erreur possible avec pip :

  ```shell
  error: externally-managed-environment
  × This environment is externally managed
  ╰─> To install Python packages system-wide, try apt install
      python3-xyz, where xyz is the package you are trying to
      install.

      If you wish to install a non-Debian-packaged Python package,
      create a virtual environment using python3 -m venv path/to/venv.
      Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
      sure you have python3-full installed.

      If you wish to install a non-Debian packaged Python application,
      it may be easiest to use pipx install xyz, which will manage a
      virtual environment for you. Make sure you have pipx installed.

      See /usr/share/doc/python3.11/README.venv for more information.

  note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
  hint: See PEP 668 for the detailed specification.
  ```

  - **Pour résoudre ce problème, ouvrez le fichier `/home/${USER}/.config/pip/pip.conf`**
    - Il est possible que ce fichier n'éxisite pas, dans ce cas créer le fichier puis ouvrez le

    ```shell
    open /home/${USER}/.config/pip/pip.conf
    ```

  - Ajouter les lignes suivantes à la fin du fichier :

    ```txt
    [global]
    break-system-packages = true
    ```

  - Sauvegarder le fichier
  - Relancer la commande qui à échoué ou tester en installant le paquet `mouse`

    ```shell
    pip install mouse
    ```

## Installation de gpt-cli - Linux

- Cloner le repertoire Github :

  ```shell
  sudo git clone https://github.com/kharvd/gpt-cli
  ```

- Aller dans le dossier du projet :

  ```shell
  cd gpt-cli
  ```

- Installer les dépendances :

  ```shell
  pip install -r requirements.txt
  ```

- Trouver la clé d'API OpenIA (l'adresse mail que j'utilise est <portgasd.ace491803@gmail.com>) sur le site :
  > <https://platform.openai.com/account/api-keys>
- Ajouter la clé d'API OpenIA dans le fichier `.bashrc` :

  **Attention, la clé d'API doit permettre d'utiliser l'API**

  ```shell
  code ~/.bashrc
  ```

  - Ajouter la ligne suivante à la fin du fichier `.bashrc` :

    ```shell
    # Ajout de la clé d'API OpenAI pour gpt-cli
    export OPENAI_API_KEY='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'
    ```

- Modifier le script python `gpt.py` :

  Remplacer cette ligne :

  ```python
  #!/usr/bin/env python
    ```

  Par cette ligne :

  ```python
  #!/usr/bin/env python3
    ```

- Executer le script python :

  ```shell
  ./gpt.py
  ```

## Installation de CMake - Linux

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install --classic cmake
  ```

## Installation de WPS Office - Linux

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install wps-office
  ```

## Installation de Smartmontools - Linux

> <https://doc.ubuntu-fr.org/smartmontools>

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install smartmontools
  ```

- Installer l'interface graphique de smartmontools du dépot `apt` :

  ```shell
  sudo apt install gsmartcontrol
  ```

## Installation de Flatpak (gestionnaire de paquets) - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install flatpak
  ```

## Installation de Mission center - Linux

- Installer le paquet du dépot `flatpak` :

  ```shell
  flatpak install flathub io.missioncenter.MissionCenter
  ```

- Allez voir le site ci-dessous pour la fin de l'installation
  > <https://dl.flathub.org/repo/appstream/io.missioncenter.MissionCenter.flatpakref>

## Installation de ZSH (interpréteur de commandes shell) - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install zsh
  ```

## Installation du gestionnaire de packet Snap - Linux

- Installer le paquet principale du dépot `apt` :

  ```shell
  sudo apt install snapd
  ```

- Installer le packet `core` du dépot `snap` :
  **Cette action peut prendre quelque minutes**

  ```shell
  sudo snap install core
  ```

## Installation de Thunderbird - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install thunderbird
  ```

## Installation de FileZilla - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install filezilla
  ```

## Installation de TestDisk - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install testdisk
  ```

## Installation de Txt2man - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install txt2man
  ```

## Installation de neofetch - Linux

script d’information sur le système, en ligne de commande

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install neofetch
  ```

## Installation de Scoop - Windows

**Scoop est un gestionnaire de paquets pour Windows. Il permet d'installer des logiciels en ligne de commande.**

- Ouvrir un terminal `PowerShell`
- Exécuter la commande suivante :

  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

- Exécuter la commande suivante :

  ```powershell
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  ```

## Installation de Jekyll - Linux

**Jekyll est un générateur de site statique écrit en Ruby. Jekyll est compatible avec GitHub Pages.**

- Installer le paquet ruby du dépot `apt` :

  ```shell
  sudo apt-get install ruby-full build-essential zlib1g-dev
  ```

- Configurer les variables d'environnement pour ruby

  ```shell
  echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
  echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
  echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
  ```

- Recharger le fichier `.bashrc`

  ```shell
  source ~/.bashrc
  ```

- Installer Jekyll et Bundler

  ```shell
  gem install jekyll bundler
  ```

## Installation de Discord - Linux

- Installation de Discord avec le dépot `snap`

    ```shell
    sudo snap install discord
    ```

- Installation de Discord avec un fichier deb
  - Télecharger le fichier deb de la dernière version sur :
    > <https://discord.com/download>
  - Executer le fichier deb

    ```shell
    sudo dpkg -i discord-*.deb
    ```

## Installation de VirtualBox

### Installation de VirtualBox en ajoutant le fichier deb dans le gestionnaire de paquets `apt`

- récupérer les clés de signature du dépôt de VirtualBox :

  ```shell
  wget -q -O- http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc | sudo apt-key add -
  ```

- Ajouter le dépôt de VirtualBox à la liste des sources de paquets :

  ```shell
  echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
  ```

  **Attention, la commande suivante est valable uniquement pour Ubuntu 22.04.1 LTS et supérieur**

  ```shell
  echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg] http://download.virtualbox.org/virtualbox/debian jammy contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
  ```

  **Pour la version 20.04.1 LTS d'ubuntu utiliser la ligne suivante**

  ```shell
  echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
  ```

- Mettre à jour la liste des paquets disponibles :

  ```shell
  sudo apt update
  ```

- Pour connaître la dernière version de virtualbox installable :

  ```shell
  apt-cache madison virtualbox
  ```

- Installer la dernière version de virtualbox (dans mon cas la version 6.1) :

  ```shell
  sudo apt install virtualbox-<version>
  ```

- Ajouter votre compte dans le groupe `vboxusers` pour avoir accès à l'USB dans vos machines virtuelles.

  ```shell
  sudo usermod -G vboxusers -a $USER
  ```

- il peut-être nécessaire de mettre à jour le module DKMS, même si moi je n'ai pas eu à le faire :

  ```shell
  sudo /etc/init.d/vboxdrv setup
  ```

### Installation en téléchargeant le fichier deb

- Télécharger le fichier deb disponible sur :
  > <https://download.virtualbox.org/virtualbox/>
- Vérifier la dernière version disponible sur :
  > <https://download.virtualbox.org/virtualbox/LATEST.TXT>
- Dans mon cas la dernière version est la 7.0.8, disponible ici :
  > <https://download.virtualbox.org/virtualbox/7.0.8/virtualbox-7.0_7.0.8-156879~Ubuntu~jammy_amd64.deb>

- Executez le fichier deb télécharger :

  ```shell
  sudo dpkg -i virtualbox-*.deb
  ```

## GParted

### Installation de GParted - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install gparted
  ```

### Allouée la partition grace à GParted - Linux

- [Installer GParted](./doc_installation.md#installation-de-gparted---linux)
- Ouvrez GParted
- Dans la liste déroulante en haut à droite, sélectionnez la clé USB
- Clique droit sur la partition non allouée
- Sélectionnez '`Nouvelle`'
- Dans 'Espace libre précédent (Mio)', entrez le minimum, dans mon cas "`1`"
- Laisser tout les autres champs par défaut
- Sélectionnez le système de fichier de votre choix, dans mon cas "`ext4`"
- Cliquez sur '`Ajouter`'

## Dconf-Editor

### Installation de Dconf-Editor - Linux

- Installer le paquet du dépot `apt` :

  ```shell
  sudo apt install dconf-editor
  ```

### Utilisation de Dconf-Editor

#### Modifier le comportement du dock (barre de tâche) de Gnome

- Ouvrir Dconf-Editor
- Allez dans `/org/gnome/shell/extensions/dash-to-dock`
- Cliquez sur '`click-action`'
- Décochez la case '`Utiliser la valeur par défaut`'
- Sélectionnez l'option que vous voulez, dans mon cas '`minimize-or-previews`'

## Pandoc

### Description

Pandoc est un logiciel qui permet de convertir des fichiers dans d'autres formats.
Il permet par exemple de convertir un fichier markdown en fichier pdf, html, docx, latex, etc... et inversement, il peux également convertir un fichier pdf en fichier markdown, html, docx, latex, etc...

### Installation de Pandoc - Linux

- Télécharger le fichier deb disponible sur :
  > <https://github.com/jgm/pandoc/releases/latest>
- Executer le fichier deb

  ```shell
  sudo dpkg -i pandoc-*-amd64.deb
  ```

### Utilisation de Pandoc

> <https://pandoc.org/MANUAL.html>

- Pour convertir un fichier

  ```shell
  pandoc -s input.<extention> -o output.<extention>
  ```

## MelonDS (émulateur de Nintendo DS) - Linux

### Installation de la version 0.9.1 de MelonDS

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install melonds
  ```

### Configuration de MelonDS

- Ouvrir MelonDS
- Aller dans le menu '`Config`' > '`Emu settings`' > '`DS-mode`'
- Séléctionner la case '`Use external BIOS/firmware files`'
- Dans l'emplacement '`DS ARM9 BIOS`', séléctionner le fichier `biosnds9.rom` Télécharger au préalable (mais je n'ai pas le site)
- Dans l'emplacement '`DS ARM7 BIOS`', séléctionner le fichier `biosnds7.rom` Télécharger au préalable (mais je n'ai pas le site)
- Dans l'emplacement '`DS firmware`', séléctionner le fichier `firmware.bin` Télécharger au préalable (mais je n'ai pas le site)
- Séléctionner '`OK`'
- Lorsque le message '`Problematic firmware dump`' apparait, séléctionner '`OK`'

### Lancer un jeu avec MelonDS

- Ouvrir MelonDS
- Aller dans le menu '`File`' > '`Open ROM`'
- Séléctionner le fichier `.nds` du jeu que vous voulez lancer

### Améliorer les graphismes de MelonDS

- Ouvrir MelonDS
- Aller dans le menu '`Config`' > '`Video settings`'
- Dans la section '`3D renderer`' Séléctionner '`OpenGL`' à la place de '`Software`'
- Dans la section '`OpenGL renderer`' Séléctionner '`4x native (1024x768)`' à la place de '`1x native (256x192)`'

### Configurer les touches de MelonDS

- Ouvrir MelonDS
- Aller dans le menu '`Config`' > '`Input and hotkeys`'
- Séléctionner la touche que vous voulez configurer

## Licence

doc_installation_et_utilisation.md

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
