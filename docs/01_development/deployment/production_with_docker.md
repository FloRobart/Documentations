# Documentation sur la mise en production avec Docker

## Table des matières

- [Documentation sur la mise en production avec Docker](#documentation-sur-la-mise-en-production-avec-docker)
    - [Table des matières](#table-des-matières)
    - [Prérequis](#prérequis)
    - [Paramètres de Visual Studio Code pour Docker avec node.js et typescript](#paramètres-de-visual-studio-code-pour-docker-avec-nodejs-et-typescript)
    - [Création d'une image Docker pour la production](#création-dune-image-docker-pour-la-production)
    - [Création du container Docker](#création-du-container-docker)
    - [Mise à jour et maintenance des conteneurs en production](#mise-à-jour-et-maintenance-des-conteneurs-en-production)
    - [Licence](#licence)

## Prérequis

- Avoir un projet fonctionnel (application web, API, etc.) prêt à être déployé en production.
- Avoir Docker installé sur votre machine pour pouvoir tester localement avant le déploiement.
    - Si vous n'avez pas encore Docker installé, vous pouvez suivre la [documentation d'installation de Docker engine](../../02_applications/docker_installation.md).

Dans ce guide, nous allons prendre pour exemple une API RESTful développée avec Node.js et Express.

Voici l'arborescence de notre projet exemple :

```txt
my_api
├── src
│   ├── fichiers_source.js
│   └── ...
├── public
│   ├── fichiers_publics.png
│   └── ...
├── package.json
├── package-lock.json
├── tsconfig.json
├── docker-compose.yml
└── docker-compose.dev.yml
```

## Paramètres de Visual Studio Code pour Docker avec node.js et typescript

Pour un confort de développement avec Visual Studio Code, vous pouvez télécharger le fichier de profil suivant : [Node.js.code-profile](../../files/Node.js.code-profile) puis l'importer dans les paramètres utilisateur de Visual Studio Code.

## Création d'une image Docker pour la production

- Documentation officielle de Docker file : <https://docs.docker.com/build/>
- Créer un fichier `.dockerignore` à la racine de votre projet.
- Dans ce fichier, nous allons spécifier les fichiers et dossiers à ignorer lors de la construction de l'image Docker. Cela permet d'être sûr de ne pas inclure des fichiers sensibles dans l'image finale.
- Copier ce texte dans le fichier `.dockerignore` à la racine de votre projet.

    ```txt
    .git
    .env
    .env.*
    node_modules
    ```

- Créer un fichier `Dockerfile` à la racine de votre projet.
    - Dans ce fichier, nous allons définir les étapes nécessaires pour construire une image Docker optimisée pour la production. Pour cela nous utiliserons un build multi-étapes afin de réduire la taille finale de l'image ainsi que d'améliorer la sécurité en n'incluant pas les fichiers sources et les dépendances de développement dans l'image finale.
- Copier ce texte dans le fichier `Dockerfile` à la racine de votre projet.
    - Chaque étape est commentée pour expliquer son rôle.

    ```Dockerfile
    # Étape 1 : Build avec TypeScript | Nous allons compiler le projet TypeScript en JavaScript pour la production
    FROM node:24-alpine AS builder # Choix de l'image de base (plus de détails sur https://hub.docker.com/_/node)
    WORKDIR /app # Repertoire de travail dans le conteneur (par convention, on utilise /app)

    # Copier le code source, les fichiers de configuration et les fichiers publics
    COPY tsconfig.json ./
    COPY package*.json ./
    COPY ./src ./src
    COPY ./public ./public

    # Supprimer les fichiers sensibles s'ils existent. Ils ne sont de toute façon pas copiés grâce au .dockerignore mais c'est une sécurité supplémentaire.
    RUN rm -f .env* public/.env* src/.env*

    # Installation des dépendances
    RUN npm ci

    # Build TypeScript → JavaScript
    RUN npm run build

    # À ce stade, le code est compilé et prêt pour la production dans le dossier /app/dist.
    " Mais vous avez encore les dépendances de développement et le code source dans l'image.

    # Étape 2 : Image finale | Nous allons créer une image légère et sécurisée pour exécuter l'application en production
    FROM node:24-alpine AS runner
    WORKDIR /app

    # Copie des fichiers nécessaires à l'exécution uniquement
    COPY package*.json ./

    # Installation des dépendances de production uniquement
    RUN npm ci --omit=dev

    COPY --from=builder /app/dist ./dist # Copie du code compilé depuis l'étape de build
    COPY --from=builder /app/public ./public # Copie des fichiers publics depuis l'étape de build

    # Ajout d'un utilisateur non-root avec UID/GID fixes
    # Utiliser les options longues pour éviter les ambiguïtés entre différentes variantes d'adduser/addgroup
    RUN addgroup --gid 1800 --system myapigroup && \
        adduser --uid 1800 --system --ingroup myapigroup --disabled-password --gecos "" --no-create-home myapiuser
    
    # Utilisation de l'utilisateur non-root créée précédemment
    USER myapiuser

    # lance le serveur Node.js (Lance le fichier principal de votre application)
    # /!\ Attention /!\ lancer directement avec node et pas avec un script npm pour éviter d'exécuter des sous-processus inutiles en production
    CMD ["node", "dist/server.js"]
    ```

    - Noter que dans l'image finale produite par ce Dockerfile, seul se qui est présent dans l'étape 2 ("runner") sera inclus. Tous se qui se passe dans l'étape 1 ("builder") sera supprimé, donc le code source TypeScript et les dépendances de développement ne seront pas présents, ce qui réduit la taille de l'image et améliore la sécurité.

## Création du container Docker

Pour la création du container Docker en production, nous allons utiliser un fichier `docker-compose.yml`. Nous pourrions utiliser des commandes `docker run`, mais l'utilisation de Docker Compose facilite la gestion des configurations et des services multiples.

- Documentation officielle de Docker Compose : <https://docs.docker.com/compose/>
- Créer un fichier `docker-compose.yml` à la racine de votre projet.
- Copier ce texte dans le fichier `docker-compose.yml` à la racine de votre projet.
    - Chaque étape est commentée pour expliquer son rôle.

    ```yaml
    services: # il y a uniquement un service dans cet exemple, mais vous pouvez en ajouter d'autres (base de données, cache, etc.)
        myapi-server: # Nom du service (choix libre)
            image: myapi-server:latest # Nom de l'image Docker (remplacer par le vôtre)
            build: # Construit l'image Docker automatiquement si elle n'existe pas
                context: . # Dossier de contexte (la racine du projet)
                dockerfile: Dockerfile # Chemin vers le Dockerfile
            restart: always # Redémarre le conteneur automatiquement en cas de plantage ou de redémarrage du serveur hôte
            env_file:
                - .env # Fichier d'environnement spécifique au service (ne pas oublier de le créer et de le configurer)
            networks:
                - myapi-net # Réseau Docker dédié (à créer plus bas dans le fichier)
            ports:
                - ${APP_PORT:-}:80 # Mappe le port 80 du conteneur au port spécifié dans la variable d'environnement APP_PORT (ou aucun port spécifique si non défini)
            security_opt:
                - no-new-privileges:true # Empêche l'élévation de privilèges dans le conteneur
            cap_drop:
                - ALL # Supprime toutes les capacités Linux du conteneur pour renforcer la sécurité
            cap_add:
                - NET_BIND_SERVICE # Ajoute uniquement la capacité nécessaire pour lier des ports
            read_only: true # Monte le système de fichiers du conteneur en lecture seule pour améliorer la sécurité
            user: "1800:1800" # Exécute le conteneur avec l'utilisateur non-root créé dans le Dockerfile
            tmpfs:
                - /tmp:exec,nosuid,nodev # Monte /tmp en tmpfs avec des options sécurisées (obligatoire si read_only est true)
            healthcheck: # Vérifie que le service est opérationnel
                test: ["CMD-SHELL", "wget -q --spider http://myapi-server:80/ || exit 1"]
                interval: 10s
                timeout: 5s
                retries: 5

    networks: # Définition des réseaux Docker
        myapi-net: # Nom du réseau (choix libre)
            driver: bridge # Type de réseau (bridge est le plus courant et sécurisé pour les applications simples)
    ```

- Pour le développement local, vous pouvez utiliser un fichier `docker-compose.dev.yml` avec des configurations adaptées au développement (montage de volumes, ports différents, etc.). Assurez-vous de ne pas utiliser ce fichier en production.
    - Pour le développement local, nous n'utiliserons pas l'image construite précédemment. En réalité nous allons utiliser l'image officielle de Node.js et monter le code source en volume pour pouvoir le modifier sans reconstruire l'image à chaque fois. Donc se qui vas se passer c'est que le code sera lancer avec nodemon pour le rechargement automatique et le container utilisera les fichiers et les dépendances présents sur la machine hôte.

    ```yaml
    myapi-server:
        image: node:24-alpine # Utilisation de l'image officielle de Node.js (la même version que dans le Dockerfile de production)
        working_dir: /app # Repertoire de travail dans le conteneur (par convention, on utilise /app)
        env_file: .env # Fichier d'environnement spécifique au service (ne pas oublier de le créer et de le configurer)
        volumes:
            - ./:/app/ # Monte le code source local dans le conteneur
            - ./node_modules:/app/node_modules # Monte les dépendances installées localement pour éviter de les réinstaller dans le conteneur
        command: sh -c "cd /app && nodemon --watch 'src/**/*.ts' --exec 'ts-node' src/server.ts" # Commande pour lancer le serveur avec nodemon et ts-node (permet le rechargement automatique)
        networks:
            - myapi-net # Réseau Docker dédié (à créer plus bas dans le fichier)
        ports:
            - ${APP_PORT}:80 # Mappe le port 80 du conteneur au port spécifié dans la variable d'environnement APP_PORT
        user: "1800:1800" # Exécute le conteneur avec un utilisateur non-root
        tmpfs:
            - /tmp:exec,nosuid,nodev # Monte /tmp en tmpfs avec des options sécurisées
            - /app/src/swagger/json:rw,uid=1800,gid=1800 # Monte le dossier swagger/json en tmpfs pour permettre l'écriture des fichiers générés par l'API

    networks: # Définition des réseaux Docker
        myapi-net: # Nom du réseau (choix libre)
            driver: bridge # Type de réseau (bridge est le plus courant et sécurisé pour les applications simples)
    ```

- Les réseaux Docker permettent aux conteneurs de communiquer entre eux de manière isolée et sécurisée. En définissant un réseau dédié pour votre application, vous pouvez contrôler quels conteneurs peuvent communiquer entre eux et limiter l'exposition aux autres conteneurs sur le même hôte Docker.

## Mise à jour et maintenance des conteneurs en production

Vous pouvez mettre à jour votre application en suivant ces étapes :

1. Apporter les modifications nécessaires à votre code source.
2. Mettre à jour le fichier `.env` si nécessaire.
3. Rebuild l'image Docker avec la commande :

   ```bash
   docker-compose -f docker-compose.yml build
   ```

4. Faire une sauvegarde de vos données si nécessaire (base de données, fichiers, etc.).
    - Si vous avez une base de données postgresql dans un autre conteneur, vous pouvez vous référer à la documentation suivante pour faire une sauvegarde : [Sauvegarde et restauration de bases de données PostgreSQL avec Docker](../database/postgresql.md#backup-dune-base-de-données-postgresql-depuis-un-conteneur-docker)
5. Stopper le conteneur en cours d'exécution :

   ```bash
   docker-compose -f docker-compose.yml down
   ```

6. Redémarrer le conteneur avec la nouvelle image :

   ```bash
   docker-compose -f docker-compose.yml up -d
   ```

7. Restaurer les données si nécessaire.
    - Si vous avez une base de données postgresql dans un autre conteneur, vous pouvez vous référer à la documentation suivante pour faire une sauvegarde : [Sauvegarde et restauration de bases de données PostgreSQL avec Docker](../database/postgresql.md#backup-dune-base-de-données-postgresql-depuis-un-conteneur-docker)

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
