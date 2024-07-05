# Documentation complète pour SSH

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

- [Documentation complète pour SSH](#documentation-complète-pour-ssh)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation de SSH](#installation-de-ssh)
    - [Installation du client SSH](#installation-du-client-ssh)
    - [Installation du serveur SSH](#installation-du-serveur-ssh)
  - [Configuration de SSH](#configuration-de-ssh)
    - [Configuration du client SSH](#configuration-du-client-ssh)
    - [Configuration du serveur SSH](#configuration-du-serveur-ssh)
  - [Utilisation de SSH](#utilisation-de-ssh)
    - [Mise en place d'un serveur SSH](#mise-en-place-dun-serveur-ssh)
    - [Connexion à un serveur](#connexion-à-un-serveur)
    - [Transfert de fichier](#transfert-de-fichier)

<div class="page"></div>

## Installation de SSH

### Installation du client SSH

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install openssh-client
  ```

### Installation du serveur SSH

- Installer le paquet du dépot `apt` :

  ```bash
  sudo apt install openssh-server
  ```

## Configuration de SSH

### Configuration du client SSH

### Configuration du serveur SSH

## Utilisation de SSH

### Mise en place d'un serveur SSH

- Autoriser le trafic SSH sur le port 22 :

  ```bash
  sudo ufw allow ssh
  ```

- Éxecuter la commande suivante pour démarrer le serveur SSH :

  ```bash
  sudo systemctl start ssh
  ```

- Pour démarrer le serveur SSH au démarrage du système :

  ```bash
  sudo systemctl enable ssh
  ```

- Pour vérifier l'état du serveur SSH :

  ```bash
  sudo systemctl status ssh
  ```

- Pour redémarrer le serveur SSH :

  ```bash
  sudo systemctl restart ssh
  ```

- Pour arrêter le serveur SSH :

  ```bash
  sudo systemctl stop ssh
  ```

### Connexion à un serveur

- Se connecter à un serveur SSH :

  ```bash
  ssh <user>@<host>
  ```

  - `<user>` : Nom d'utilisateur à utiliser sur le serveur
  - `<host>` : Adresse IP ou nom de domaine

### Transfert de fichier

- Transférer un fichier vers un serveur SSH :

  ```bash
  scp <fichier> <user>@<host>:<destination>
  ```

  - `<fichier>` : Fichier local à transférer
  - `<user>` : Nom d'utilisateur à utiliser sur le serveur
  - `<host>` : Adresse IP ou nom de domaine
  - `<destination>` : Destination du fichier sur le serveur

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
