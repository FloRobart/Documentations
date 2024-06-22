# Documentation d'explications de manipulations diverses

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

- [Documentation d'explications de manipulations diverses](#documentation-dexplications-de-manipulations-diverses)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Réinitialiser une clé USB ou un disque dur](#réinitialiser-une-clé-usb-ou-un-disque-dur)
  - [Changer le point de montage de la partition Windows sous Ubuntu desktop 22.04 et supérieur](#changer-le-point-de-montage-de-la-partition-windows-sous-ubuntu-desktop-2204-et-supérieur)
  - [Monter uniquement un dossier](#monter-uniquement-un-dossier)
  - [Exécuter un script shell au démarrage d'Ubuntu 22.04 ou supérieur](#exécuter-un-script-shell-au-démarrage-dubuntu-2204-ou-supérieur)
    - [Exécuter le script en tant que super administrateur (pour les commandes sudo)](#exécuter-le-script-en-tant-que-super-administrateur-pour-les-commandes-sudo)
    - [Exécuter le script en tant que l'utilisateur de la session en cours d'utilisation](#exécuter-le-script-en-tant-que-lutilisateur-de-la-session-en-cours-dutilisation)
  - [Mettre à jour Ubuntu 23.04 Lunar Lobster vers Ubuntu 23.10 Mantic Minotaur](#mettre-à-jour-ubuntu-2304-lunar-lobster-vers-ubuntu-2310-mantic-minotaur)
  - [Réinstallation de l'envirronement graphique de Ubuntu (gnome)](#réinstallation-de-lenvirronement-graphique-de-ubuntu-gnome)
  - [Mode Terminal de Ubuntu](#mode-terminal-de-ubuntu)
  - [Modifier l'action du click sur une l'icone de l'application](#modifier-laction-du-click-sur-une-licone-de-lapplication)
    - [Avec le terminal](#avec-le-terminal)
    - [Avec une application tierce](#avec-une-application-tierce)
  - [Désinstallation de fichier deb](#désinstallation-de-fichier-deb)
  - [Réinstallation de windows à partir d'une image système](#réinstallation-de-windows-à-partir-dune-image-système)
    - [Création d'une image de la partition windows](#création-dune-image-de-la-partition-windows)
    - [Réinstallation de windows](#réinstallation-de-windows)
  - [Mettre à jour snap store d'Ubuntu](#mettre-à-jour-snap-store-dubuntu)
  - [Problème avec le gestionnaire de paquets apt - Linux](#problème-avec-le-gestionnaire-de-paquets-apt---linux)

<div class="page"></div>

## Réinitialiser une clé USB ou un disque dur

**Supprimme toutes les données et toute les partitions de la clé USB**

- fermet tout les gestionnaires de fichiers et terminaux ouverts sur la clé USB.
- Ouvrez un terminal
- Passez en mode admin :

  ```shell
  sudo su
  ```

- Listez les lecteurs :

  ```shell
  fdisk -l
  ```

- Administrez le lecteur de votre choix :

  X est la lettre de la clé USB

  ```shell
  fdisk /dev/sdX
  ```

  dans mon cas :

  ```shell
  fdisk /dev/sda
  ```

- Supprimez toutes les partitions : "`d X`"

  X est le numéro de la partition, dans mon cas : "`d 1`" et "`d 2`"

- Créez une nouvelle partition : "`n`"
- Choisissez le type de partition : "`p`"
- Choisissez le numéro de la partition : "`1`"
- Choisissez le premier cylindre, laisser la valeur par defaut et appuyer sur entrer
- Choisissez le dernier cylindre, laisser la valeur par defaut et appuyer sur entrer
- Sauvegardez les modifications : "`w`"
- Quittez fdisk : "`q`"

Vous avez maintenant une clé USB vierge avec 1 partition non allouée

## Changer le point de montage de la partition Windows sous Ubuntu desktop 22.04 et supérieur

- Récupérer le nom de la partition windows :

  ```shell
  sudo fdisk -l
  ```

  - Sortie de la commande :

    ```shell
    ...

    Périphérique       Début        Fin  Secteurs Taille Type
    /dev/nvme0n1p1      2048     309247    307200   150M Système EFI
    /dev/nvme0n1p2    309248     571391    262144   128M Réservé Microsoft
    /dev/nvme0n1p3    571392  629715869 629144478   300G Données de base Microsoft
    /dev/nvme0n1p4 629716992  632066047   2349056   1,1G Environnement de récupérati
    /dev/nvme0n1p5 632066048  962566143 330500096 157,6G Système de fichiers Linux
    /dev/nvme0n1p6 962566600  998334463  35767864  17,1G Environnement de récupérati
    /dev/nvme0n1p7 998334464 1000214527   1880064   918M Environnement de récupérati

    ...
    ```

- Démonter la partition windows qui se nomme dans mon cas `/dev/nvme0n1p3` mais ça peut être différent :

  ```shell
  sudo umount /dev/nvme0n1p3
  ```

- Créer le dossier dans lequel sera monté la partition :

  ```shell
  sudo mkdir /OS
  ```

- Donner les droits d'accès au dossier sinon la partition ne pourra pas être monté dans ce dossier :

  ```shell
  sudo chmod 777 /OS
  ```

- Vérifier que la partition peut être monté dans le dossier :

  ```shell
  sudo mount /dev/nvme0n1p3 /OS
  ```

  - Si cette opération à fonctionner, vous pouvez démonter la partition à nouveau puis passer à l'étape suivante

    ```shell
    sudo umount /dev/nvme0n1p3
    ```

- Copier le fichier `/etc/fstab` dans le dossier `/etc/fstab_sauvegarde` :

  ```shell
  sudo cp /etc/fstab /etc/fstab_sauvegarde
  ```

- Ajouter ces lignes au fichier `/etc/fstab` :

  ```shell
  # Montage de la partition Windows
  /dev/nvme0n1p3	/OS	ntfs3	rw,user,auto,exec,gid=1000,uid=1000,umask=002, utf8,codepage=850,shortname=mixed	0	0
  ```

  - Chaque champs est séparé par une tabulation
  - "`# Montage de la partition Windows`" : commentaire optionnel
  - "`/dev/nvme0n1p3`" : nom de la partition
  - "`/OS`" : dossier dans lequel sera monté la partition
  - "`ntfs3`" : système de fichiers de la partition
  - "`rw,user,auto,exec,gid=1000,uid=1000,umask=002, utf8,codepage=850,shortname=mixed`" : options de montage
  - "`0`" : 0 pour ne pas faire de sauvegarde de la partition, 1 pour faire une sauvegarde de la partition
  - "`0`" : 0 pour ne pas vérifier la partition au démarrage, 1 pour vérifier la partition au démarrage

- Redémarrer l'ordinateur (cela peut prendre quelque minutes) :

  ```shell
  sudo reboot
  ```

## Monter uniquement un dossier

**Attention, un dossier peut être monter uniquement si la partition sur laquelle il se trouve est monté au préalable**

- Créer le dossier dans lequel sera monté le dossier :

  ```shell
  sudo mkdir /home/${USER}/<nom_du_dossier>
  ```

- Executer la commande suivant pour monter le dossier

  ```shell
  sudo mount --bind /<chemin_du_dossier_a_monte> /home/${USER}/<nom_du_dossier>
  ```

  - Dans mon cas

    ```shell
    sudo mount --bind /OS/Mon_Drive/ /home/${USER}/Mon_Drive/
    ```

## Exécuter un script shell au démarrage d'Ubuntu 22.04 ou supérieur

### Exécuter le script en tant que super administrateur (pour les commandes sudo)

- Ouvrer le fichier `crontab` en administrateur grace à la commande suivante :

  ```shell
  sudo crontab -u root -e
  ```

- Si c'est la première fois que vous éditer ce fichier un choix d'éditeur vous sera demander. Choisissez celui que vous voulez mais je vous conseil fortement d'utiliser **`nano`** qui doit être en numéro **`1`**
- Ajouter la ligne suivante à la fin du fichier

  **Surtout n'utiliser pas de variable d'environnement comme `${USER}` parce qu'il est lancer en tant que root et que la variable ${USER} est vide lors de l'éxecution du script**

  ```shell
  @reboot /path/to/script.sh
  ```

  - Dans mon cas

    ```shell
    @reboot /home/floris/.scripts_on_boot/mount_mon_drive.sh
    ```

- Sauvegarder le fichier
  > Ctrl + X
- Confirmer la sauvegarde
- Ne modifier surtout pas pas le nom du fichier, appuyer sur entrer pour confirmer le nom qui entrer par défaut
- Redémarrer l'ordinateur pour vérifier que le script s'exécute bien au démarrage

  ```shell
  reboot
  ```

### Exécuter le script en tant que l'utilisateur de la session en cours d'utilisation

- Ouvrer le fichier `crontab` grace à la commande suivante :

  ```shell
  crontab -e
  ```

- Si c'est la première fois que vous éditer ce fichier un choix d'éditeur vous sera demander. Choisissez celui que vous voulez mais je vous conseil fortement d'utiliser **`nano`** qui doit être en numéro **`1`**
- Ajouter la ligne suivante à la fin du fichier

  ```shell
  @reboot /path/to/script.sh
  ```

- Sauvegarder le fichier
  > Ctrl + X
- Confirmer la sauvegarde
- Ne modifier surtout pas pas le nom du fichier, appuyer sur entrer pour confirmer le nom qui entrer par défaut
- Redémarrer l'ordinateur pour vérifier que le script s'exécute bien au démarrage

  ```shell
  reboot
  ```

## Mettre à jour Ubuntu 23.04 Lunar Lobster vers Ubuntu 23.10 Mantic Minotaur

- Vérifier que vous êtes bien sur Ubuntu 23.04 grâce à la commande suivante

  **Il peut être nécessaire de l'installer (via [le packet apt neofetch](./doc_installation.md#installation-de-neofetch---linux))**

  ```shell
  neofetch
  ```

  - Vous pouvez voir dans la sortie de la commande qu'en face de `OS` il y a écrit `Ubuntu 23.04` avec l'architecture de votre système, dans mon cas `x86_64`

    ```shell
                .-/+oossssoo+/-.               floris@floris-Inspiron-5402 
            `:+ssssssssssssssssss+:`           --------------------------- 
          -+ssssssssssssssssssyyssss+-         OS: Ubuntu 23.04 x86_64 
        .ossssssssssssssssssdMMMNysssso.       Host: Inspiron 5402 
       /ssssssssssshdmmNNmmyNMMMMhssssss/      Kernel: 6.2.0-34-generic 
      +ssssssssshmydMMMMMMMNddddyssssssss+     Uptime: 16 hours, 5 mins 
     /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Packages: 1893 (dpkg), 15 (snap) 
    .ssssssssdMMMNhsssssssssshNMMMdssssssss.   Shell: bash 5.2.15 
    +sssshhhyNMMNyssssssssssssyNMMMysssssss+   Resolution: 3840x2160 
    ossyNMMMNyMMhsssssssssssssshmmmhssssssso   DE: GNOME 44.3 
    ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM: Mutter 
    +sssshhhyNMMNyssssssssssssyNMMMysssssss+   WM Theme: Adwaita 
    .ssssssssdMMMNhsssssssssshNMMMdssssssss.   Theme: Yaru-dark [GTK2/3] 
     /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/    Icons: Yaru [GTK2/3] 
      +sssssssssdmydMMMMMMMMddddyssssssss+     Terminal: gnome-terminal 
       /ssssssssssshdmNNNNmyNMMMMhssssss/      CPU: 11th Gen Intel i7-1165G7 (8) @ 4.700GHz 
        .ossssssssssssssssssdMMMNysssso.       GPU: Intel TigerLake-LP GT2 [Iris Xe Graphics] 
          -+sssssssssssssssssyyyssss+-         Memory: 4175MiB / 15712MiB 
            `:+ssssssssssssssssss+:`
                .-/+oossssoo+/-.
    ```

- Ouvrez le logiciel `Logiciels et mise à jour` (en anglais `Software & Updates`)

  !["Image de l'icon du logiciel de mise à jour de Ubuntu"](../Images/icon_ubuntu_software_and_update.png "Image de l'icon du logiciel de mise à jour de Ubuntu")

- Allez dans l'onglet '`Mise à jour`'

  !["Image du logiciel de mise à jour de Ubuntu"](../Images/logiciel_ubuntu_software_and_update.png "Image du logiciel de mise à jour de Ubuntu")

- Changer la valeur de '`Me prévenir lorsqu'une nouvelle version d'Ubuntu est disponible`' en '`Pour chaque nouvelle version`'

  !["Image de la section mise à jour du logiciel de mise à jour de Ubuntu"](../Images/a_changer_dans_ubuntu_software_and_update.png "Image de la section mise à jour du logiciel de mise à jour de Ubuntu")

- Fermer le logiciel de mise à jour
- Ouvrer un terminal
- Exécuter la commande suivante pour chercher les mises à jour de paquet à faire :

  ```shell
  sudo apt update
  ```

- Exécuter la commande suivante pour mettre à jour les paquets :

  ```shell
  sudo apt upgrade
  ```

- Ouvrer le fichier `/etc/update-manager/release-upgrades` avec un éditeur de texte :

  ```shell
  code /etc/update-manager/release-upgrades
  ```

  - Vérifier que la dernière ligne est la même que celle ci-dessous et que la valeur de `Prompt` est bien `normal`, si se n'est pas le cas modifier votre fichier
  - Résultat attendu :

    ```shell
    # Default behavior for the release upgrader.

    [DEFAULT]
    # Default prompting and upgrade behavior, valid options:
    #
    #  never  - Never check for, or allow upgrading to, a new release.
    #  normal - Check to see if a new release is available.  If more than one new
    #           release is found, the release upgrader will attempt to upgrade to
    #           the supported release that immediately succeeds the
    #           currently-running release.
    #  lts    - Check to see if a new LTS release is available.  The upgrader
    #           will attempt to upgrade to the first LTS release available after
    #           the currently-running one.  Note that if this option is used and
    #           the currently-running release is not itself an LTS release the
    #           upgrader will assume prompt was meant to be normal.
    Prompt=normal

    ```

- Vous pouvez maintenant fermer l'éditeur de texte
- Vous pouvez maintenant forcer le processus de mise à jour dans le terminal grâce à la commande suivante :

  ```shell
  sudo do-release-upgrade
  ```

- Si il vous affiche '`No new release found`' il existe deux solution :
  - Réessayer la commande `sudo do-release-upgrade` avec l'option `-d` :

    ```shell
    sudo do-release-upgrade -d
    ```
  
  - Sinon attendez quelque jour puis recommencer. Cela peux être du au fait que votre ordinateur n'est pas supporter par la nouvelle la version 23.10 de Ubuntu

## Réinstallation de l'envirronement graphique de Ubuntu (gnome)

- pour réinstaller l'envirronement graphique lancer la commande

  ```shell
  sudo apt-get install --reinstall ubuntu-desktop
  ```

- redémarer l'ordinateur

  ```shell
  reboot
  ```

## Mode Terminal de Ubuntu

- Pour ouvrir le mode terminal d'ubuntu
  > Ctrl + Alt + F3
- Pour quitter le mode terminal d'ubuntu
  > Alt + F2

## Modifier l'action du click sur une l'icone de l'application

### Avec le terminal

- Ouvrez un terminal

  ```sh
  gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
  ```

### Avec une application tierce

[Modifier l'action du click avec une application tierce](./doc_installation_et_utilisation.md#modifier-le-comportement-du-dock-barre-de-tâche-de-gnome)

## Désinstallation de fichier deb

- source
  ><https://www.baeldung.com/linux/apt-uninstall-dpkg-deb-package>
- Pour désinstaller un fichier deb, il faut utiliser la commande `dpkg` avec l'option `-r` ou `--remove` :

  ```shell
  sudo dpkg -r <nom_du_fichier_deb>
  ```

- Pour désinstaller et supprimer tout les fichiers de configuration d'un fichier deb, il faut utiliser la commande `dpkg` avec l'option `--purge` :

  ```shell
  sudo dpkg --purge <nom_du_fichier_deb>
  ```

## Réinstallation de windows à partir d'une image système

La réinstallation de windows à partir d'une image système permet de réinstaller windows sans perdre les données de la partition windows. Cette action est très longue, il faut compter plusieurs heures.

### Création d'une image de la partition windows

- Ouvrir le logiciel `Panneau de configuration`
- Aller dans `Système et sécurité` > `Sauvegarder et restaurer (Windows 7)`
- Cliquer sur `Créer une image système`
- Sélectionner le disque dur sur lequel vous voulez créer l'image système
- Cliquer sur `Suivant`
- Patienter pendant la création de l'image système, cela peut prendre entre 30 minutes et 2 heures (environs)

### Réinstallation de windows

- Boot sur la clé USB Ventoy
- Sélectionner le dossier correspondant à Windows
- Sélectionner les information de langage suivant :
  - Langue à installer : '`Français (France)`'
  - Format horaire et monétaire : '`Français (France)`'
  - Clavier ou méthode d'entré : '`Français`'
- Cliquer sur '`Suivant`'
- Au moment de l'installation cliquer sur '`Réparer l'ordinateur`'
- Cliquer sur '`Dépannage`'
- Cliquer sur '`Récupération de l'image système`'
- Cliquez sur votre image, normalement il y en a qu'une
- Sélectionner '`utiliser la dernière image système (recommendé)`'
- Cliquer sur '`Suivant`'
- Sélectionner '`Formater et répartionner les disques`'
- **Attention très important**
  - Sélectionner les disques à exclure de la réinstallation de windows, dans mon cas j'ai sélectionner tout les disques sauf celui sur lequel je veux réinstaller windows
- Cliquer sur '`Suivant`'
- Laisser les options `Date et heure`, `Ordinateur` et `Lecteurs à restaurer` par défaut
- Cliquer sur '`Terminer`'
- Confirmer la réinstallation de windows en cliquant sur '`Oui`'
- Patienter pendant la réinstallation de windows, cela est très long (plusieurs heures)
- de retour sur l'affichage de ventoy, redémarrer l'ordinateur

## Mettre à jour snap store d'Ubuntu

```shell
snap-store --quit && sudo snap refresh snap-store
```

## Problème avec le gestionnaire de paquets apt - Linux

- Si vous avez un problème avec le gestionnaire de paquets apt, lancer la commande :

  ```shell
  sudo apt --fix-broken install
  ```

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
