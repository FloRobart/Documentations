# Documentation Git, GitHub, GitLab et autres outils basés sur Git

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

- [Documentation Git, GitHub, GitLab et autres outils basés sur Git](#documentation-git-github-gitlab-et-autres-outils-basés-sur-git)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation](#installation)
    - [Installation de Git sur Ubuntu Desktop et Debian](#installation-de-git-sur-ubuntu-desktop-et-debian)
    - [Installation de Git sur Windows 10 et 11](#installation-de-git-sur-windows-10-et-11)
  - [Configuration](#configuration)
    - [Configuration pour Linux et Windows](#configuration-pour-linux-et-windows)
    - [Liaison avec Github sur Linux et Windows](#liaison-avec-github-sur-linux-et-windows)
  - [Utilisation](#utilisation)
    - [Utilisation de plusieurs comptes Github sur le même ordinateur - Ubuntu](#utilisation-de-plusieurs-comptes-github-sur-le-même-ordinateur---ubuntu)
      - [Configuration pour Git](#configuration-pour-git)
      - [Configuration pour SSH et Github](#configuration-pour-ssh-et-github)
    - [Remplacer la branch master par une autre branch](#remplacer-la-branch-master-par-une-autre-branch)
    - [Création d'un workflow Github pour Laravel](#création-dun-workflow-github-pour-laravel)
  - [Erreur](#erreur)
    - [Erreur d'authentification HTTPS](#erreur-dauthentification-https)
    - [Erreur le nom gitbug.com ne peut pas être résolu](#erreur-le-nom-gitbugcom-ne-peut-pas-être-résolu)
  - [Licence](#licence)

<div class="page"></div>

## Installation

### Installation de Git sur Ubuntu Desktop et Debian

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

### Installation de Git sur Windows 10 et 11

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

## Configuration

### Configuration pour Linux et Windows

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

### Liaison avec Github sur Linux et Windows

- Générer une clé SSH :

  ```shell
  ssh-keygen -t rsa -b 4096 -C "votre adresse mail"
  ```

- laisser vide les trois champs suivant :

  > Enter file in which to save the key (/home/$USER/.ssh/id_rsa):

  > Enter passphrase (empty for no passphrase):

  > Enter same passphrase again:

- Ajouter la clé public (présente dans le fichier `~/.ssh/id_rsa.pub`) à Github dans '`Settings`' > '`SSH and GPG keys`' > '`New SSH key`'

## Utilisation

### Utilisation de plusieurs comptes Github sur le même ordinateur - Ubuntu

- Source
  > <https://gist.github.com/bonnopc/c78920431284ce3fc2a5270016205116>

La documentation ci-dessous utilise deux comptes Github, avec deux clés SSH différentes, mais vous pouvez l'adapter pour autant de comptes que vous voulez.

#### Configuration pour Git

- Placez-vous dans le dossier de votre projet

  ```shell
  cd /chemin/vers/votre/projet
  ```

- Modifier votre adresse mail pour un projet spécifique

  ```shell
  git config user.email "Votre adresse mail"
  ```

- Modifier votre nom d'utilisateur pour un projet spécifique

  ```shell
  git config user.name "Votre nom"
  ```

#### Configuration pour SSH et Github

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

### Remplacer la branch master par une autre branch

- Source
  > <https://stackoverflow.com/questions/2862590/how-to-replace-master-branch-in-git-entirely-from-another-branch>
- Vérifier que la branch master est bien à jour

  ```shell
  git checkout master
  git pull
  ```

- Passer sur la branch que vous voulez mettre à la place de la branch master que nous appelons `<new_branch>` et vérifier qu'elle est bien à jour

  ```shell
  git checkout <new_branch>
  git pull
  ```

- Fusionner la branch `<new_branch>` avec la branch master en écrasant la branch master

  ```shell
  git merge -s ours master
  ```

- Passer sur la branch master

  ```shell
  git checkout master
  ```

- Fusionner la branch `<new_branch>` avec la branch master

  ```shell
  git merge <new_branch>
  ```

- Mettre à jour la branch master sur Github

  ```shell
  git push origin master
  ```

### Création d'un workflow Github pour Laravel

- Source
  > <https://docs.github.com/fr/enterprise-cloud@latest/actions/using-workflows/creating-starter-workflows-for-your-organization>

## Erreur

### Erreur d'authentification HTTPS

- Ne pas passer par HTTPS, il faut utiliser le ssh pour communiquer avec Github. Si votre clé ssh est bien configurer comme indiquer au dessus vous n'aurez normalement pas de problème.

- Sinon vous pouvez aussi mêtre un token à la place du mot de passe mais il faudra le remettre à chaque action que vous effectuer sur Github

  - Générer un token d'authentification sur Github dans '`Settings`' > '`Developer settings`' > '`Personal access tokens`' > '`Fine-grained personal access tokens`' > '`Generate new token`'

  - Sélectionner quel repo vous voulez accéder avec votre token, dans mon cas j'ai sélectionné '`All repositories`'

  - Donner les autororisations que vous voulez, dans mon cas j'ai sélectionné la plus haute autorisation de chaque élément de la catégorie `Repository permissions` et j'ai rien toucher à l'autre catégorie.

  - Cliquer sur '`Generate token`'

### Erreur le nom gitbug.com ne peut pas être résolu

- Si vous obtenez l'erreur ci-dessous :

  ```shell
  ssh: Could not resolve hostname github.com: Temporary failure in name resolution
  fatal: Impossible de lire le dépôt distant.
  ```

- Vérifier que vous avez bien une connexion internet
- Si votre connexion internet fonctionne, vérifier que vous pouvez accéder à Github

  ```shell
  ping github.com
  ```

- Si vous obtenez l'erreur ci-dessous :

  ```shell
  ping: github.com: Temporary failure in name resolution
  ```

- Ça veut dire que vous avez un problème de DNS, ouvrez le fichier `/etc/resolv.conf`
  
  ```shell
  sudo nano /etc/resolv.conf
  ```

- Ajouter donc les lignes suivantes dans le fichier `/etc/resolv.conf`

  ```conf
  ...
  nameserver 8.8.8.8
  nameserver 8.8.4.4
  ```

- Sauvegarder le fichier
- Relancer la commande ping pour vérifier que vous avez bien accès à Github

    ```shell
    ping github.com
    ```

## Licence

doc_git.md

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
