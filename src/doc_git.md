# Installation et configuration de git sur Linux et Windows

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

<div style="page-break-after: always;"></div>

## Table des matières

***

- [Installation et configuration de git sur Linux et Windows](#installation-et-configuration-de-git-sur-linux-et-windows)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation de git sur Ubuntu Desktop et Debian](#installation-de-git-sur-ubuntu-desktop-et-debian)
  - [Installation sur Windows 10 et 11](#installation-sur-windows-10-et-11)
  - [Configuration pour Linux et Windows](#configuration-pour-linux-et-windows)
  - [Liaison avec Github sur Linux et Windows](#liaison-avec-github-sur-linux-et-windows)
  - [Utilisation de plusieurs comptes Github sur le même ordinateur - Ubuntu](#utilisation-de-plusieurs-comptes-github-sur-le-même-ordinateur---ubuntu)

<div style="page-break-after: always;"></div>

## Installation de git sur Ubuntu Desktop et Debian

- Installer le paquet `git` depuis le dépot `apt` :

  ```shell
  sudo apt install git
  ```

- Pour vérifier l'installation ouvrez un terminal et lancer la commande :

  ```shell
  git --version
  ```

  - Résultat attendu :

    ```shell
    git version 2.34.1
    ```

## Installation sur Windows 10 et 11

- Télécharger le fichier d'installation sur le site officiel :
  
  > <https://git-scm.com/download/win>

- Ouvrir le fichier d'installation
- Suivre les instructions d'installation
- Séléctionner l'option '`Add a Git Bash Profile to Windows Terminal`'
- Ne pas séléctionner l'option '`Use Git from Git Bash only`' pour pouvoir utiliser git depuis le terminal windows
- Changer l'éditeur de texte par défaut si vous en avez envie
- Laisser toutes les autres options par défaut
- Cliquer sur '`Install`'
- Pour vérifier l'installation ouvrez un terminal et lancer la commande :

  ```shell
  git --version
  ```

  - Résultat attendu :

    ```shell
    git version 2.41.0.windows.1
    ```

## Configuration pour Linux et Windows

- Si vous avez besoins d'aide pour la configuration de git, lancer la commande :

  ```shell
  git help config
  ```

- Configurer l'adresse mail :

  ```shell
  git config --global user.email <adresse mail>
  ```

- Configurer l'adresse mail :

  ```shell
  git config --global user.name <votre prenom>
  ```

## Liaison avec Github sur Linux et Windows

- Générer une clé SSH :

  ```shell
  ssh-keygen -t rsa -b 4096 -C "votre adresse mail"
  ```

- laisser vide les trois champs suivant :

  > Enter file in which to save the key (/home/$USER/.ssh/id_rsa):

  > Enter passphrase (empty for no passphrase):

  > Enter same passphrase again:

- Ajouter la clé public (présente dans le fichier `~/.ssh/id_rsa.pub`) à Github dans '`Settings`' > '`SSH and GPG keys`' > '`New SSH key`'

## Utilisation de plusieurs comptes Github sur le même ordinateur - Ubuntu

**Source : <https://gist.github.com/bonnopc/c78920431284ce3fc2a5270016205116>**

La documentation ci-dessous utilise deux comptes Github, avec deux clés SSH différentes, mais vous pouvez l'adapter pour autant de comptes que vous voulez.

- Générer une nouvelle clé SSH comme indiqué dans la section [Liaison avec Github sur Linux et Windows](#liaison-avec-github-sur-linux-et-windows)
- Effacer les clés mises en cache précédentes

  ```shell
  ssh-add -D
  ```

  - Si vous obtenez l'erreur ci-dessous :

    ```shell
    Error connecting to agent: Connection refused
    ```

  - Activer l'agent SSH

    ```shell
    eval "$(ssh-agent)"
    ```

  - Réessayer d'effacer les clés mises en cache

    ```shell
    ssh-add -D
    ```

- Ajouter vos clés SSH à l'agent SSH

  ```shell
  ssh-add ~/.ssh/id_rsa
  ssh-add ~/.ssh/id_rsa_2
  ...
  ```

- Si vous le souhaitez, vous pouvez vérifier les clés ajoutées à l'agent SSH avec la commande

  ```shell
  ssh-add -l
  ```

- Si vous n'en avez pas déjà un, créer un fichier de configuration SSH

  ```shell
  touch ~/.ssh/config
  ```

- Ouvrir le fichier de configuration

  ```shell
  open ~/.ssh/config
  ```

- Modifier le fichier de configuration pour ajouter les configurations suivantes

  ```shell
  # Compte github 1
  Host <NOM>.github.com
  HostName github.com
  IdentitiesOnly yes
  IdentityFile <~/.ssh/id_rsa_1>

  # Compte github 2
  Host <NOM>.github.com
  HostName github.com
  IdentitiesOnly yes
  IdentityFile <~/.ssh/id_rsa_rsa_2>
  ```

  - Remplacer `<NOM>` par le nom de votre compte Github
  - Remplacer `~/.ssh/id_rsa_1` et `~/.ssh/id_rsa_2` par le chemin complet de vos clés SSH

- Cloner un dépôt Github

  ```shell
  git clone git@<NOM>.github.com:exemple/exemple-repo.git
  ```

  - Remplacer `<NOM>` par le nom du compte Github que vous voulez utiliser

- Modifier un dépôt Github existant
  - Aller dans le dossier du dépôt
  - Modifier le fichier `.git/config`

    ```shell
    open .git/config
    ```
  
  - Modifier l'URL du dépôt

    ```config
    [remote "origin"]
	    url = git@<NOM>.github.com:exemple/exemple-repo.git
    ```

- Vérifier que tout fonctionne correctement en poussant un changement

  ```shell
  git add .
  git commit -m "Message de commit"
  git push
  ```

***

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
