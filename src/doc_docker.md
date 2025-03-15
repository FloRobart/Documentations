# Documentation Docker engine

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

- [Documentation Docker engine](#documentation-docker-engine)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Sources](#sources)
  - [Introduction](#introduction)
  - [Installation de Docker engine sur Ubuntu 24.XX](#installation-de-docker-engine-sur-ubuntu-24xx)

## Sources

- [Documentation officiel d'installation de Docker engine](https://docs.docker.com/engine/install/ubuntu/)
- [Documentation officiel de post installation de Docker engine](https://docs.docker.com/engine/install/linux-postinstall/)

## Introduction

- **Docker engine :** Docker engine est un logiciel qui permet de créer, de déployer et de gérer des conteneurs. Les conteneurs sont des environnements isolés qui contiennent tout le nécessaire pour exécuter une application, y compris le code, les bibliothèques système, les outils système et les fichiers système.
- **Docker desktop :** Docker desktop est une interface graphique optionnel pour Docker engine. Lors de l'installation de docker desktop docker engine est automatiquement installée.
  - Si vous voulez installer docker desktop, vous pouvez suivre la [documentation officiel d'installation de Docker desktop](https://docs.docker.com/desktop/setup/install/linux/).

## Installation de Docker engine sur Ubuntu 24.XX

- Pour commencer désinstaller les anciennes versions de Docker

  ```bash
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  ```

- Mettre à jour le gestionnaire de paquet

  ```bash
  sudo apt update
  ```

- Installer `curl` et `ca-certificates`

  ```bash
  sudo apt install curl ca-certificates
  ```

- Créer le répertoire `/etc/apt/keyrings` avec les permissions `0755`

  ```bash
  sudo install -m 0755 -d /etc/apt/keyrings
  ```

- Télécharger la clé GPG de Docker

  ```bash
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  ```

- Changer les permissions de la clé GPG

  ```bash
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  ```

- Ajouter le dépôt Docker à Apt sources

  ```bash
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  ```

- Installer Docker engine

  ```bash
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  ```

- Créer un groupe `docker`

  ```bash
  sudo groupadd docker
  ```

- Ajouter votre utilisateur au groupe `docker`

  ```bash
  sudo usermod -aG docker $USER
  ```

- Mettre à jour les permissions du groupe `docker`

  ```bash
  newgrp docker
  ```

- Tester l'installation de Docker engine

  ```bash
  docker run hello-world
  ```

  - Réponse attendue :

    ```txt
    Hello from Docker!
    This message shows that your installation appears to be working correctly.

    To generate this message, Docker took the following steps:
    1. The Docker client contacted the Docker daemon.
    2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
    3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
    4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.

    To try something more ambitious, you can run an Ubuntu container with:
    $ docker run -it ubuntu bash

    Share images, automate workflows, and more with a free Docker ID:
    https://hub.docker.com/

    For more examples and ideas, visit:
    https://docs.docker.com/get-started/
    ```
