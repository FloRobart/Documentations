# Documentation Postgresql

## Table des matières

- [Documentation Postgresql](#documentation-postgresql)
    - [Table des matières](#table-des-matières)
    - [Création de la base de données avec Docker](#création-de-la-base-de-données-avec-docker)
    - [Backup d'une base de données PostgreSQL depuis un conteneur Docker](#backup-dune-base-de-données-postgresql-depuis-un-conteneur-docker)
    - [Licence](#licence)

## Création de la base de données avec Docker

- Créer un projet pour votre application.
- Créer un dossier Database pour y stocker tous se dont vous avez besoin pour la base de données.
- Créer les scripts SQL de création des tables et des données initiales.

    ```sql
    CREATE TABLE example_table (
        id SERIAL PRIMARY KEY,
        ex_name VARCHAR(100) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```

- Créer un fichier `Dockerfile` dans le dossier Database avec le contenu suivant :

    ```Dockerfile
    FROM postgres:latest # Image officielle de PostgreSQL

    # /!\ IMPORTANT /!\ #
    # /!\ This is the default configuration, you need to override it with a .env file in the same folder as your docker-compose.yml #
    ENV POSTGRES_USER=postgres
    ENV POSTGRES_PASSWORD=postgres
    ENV POSTGRES_DB=mydb

    # Copier les scripts SQL dans le dossier d'initialisation de PostgreSQL
    COPY ./path_to_sql_file/*.sql /docker-entrypoint-initdb.d/
    COPY ./second_path_to_sql_file/*.sql /docker-entrypoint-initdb.d/
    ...
    ```

    - Attention l'ordre de copie des fichiers SQL est important, car ils seront exécutés dans cet ordre lors de la création du conteneur. Le mieux est encore de les nommer avec un préfixe numérique pour s'assurer de l'ordre d'exécution (01_init.sql, 02_create_tables.sql, 03_insert_data.sql, etc.).
- Il est recommander de lancer la base de données avec le docker-compose du serveur back-end, mais vous pouvez aussi créer un docker-compose spécifique pour la base de données si vous le souhaitez. Dans tous les cas le contenue sera le même.

    ```yaml
    services:
        my-db:
            build:
                context: . # Chemin vers le dossier contenant le Dockerfile de la base de données
                dockerfile: Dockerfile # Nom du Dockerfile
            image: my-db:latest
            environment: # Variables d'environnement pour la configuration de PostgreSQL
                POSTGRES_DB: ${DB_NAME}
                POSTGRES_USER: ${DB_USER}
                POSTGRES_PASSWORD: ${DB_PASSWORD}
            volumes:
                - db_data:/var/lib/postgresql # Persister les données de la base de données
            networks:
                - my-net # Connecter le conteneur à un réseau Docker existant
            healthcheck:
                test: ["CMD-SHELL", "pg_isready -U ${DB_USER} -d ${DB_NAME} || exit 1"] # Vérifier si PostgreSQL est prêt et opérationnel
                interval: 5s
                timeout: 30s
                retries: 5

    volumes:
        db_data: # Volume Docker pour persister les données de la base de données

    networks:
        my-net: 
            driver: bridge
    ```

    - Il ne faut pas exposer de port pour que la base de données soit accessible uniquement par les autres conteneurs du même réseau Docker. Cela améliore beaucoup la sécurité de votre base de données.
    - Pour connecter votre application à la base de données, assurez-vous qu'il soit sur le même réseau Docker et d'utiliser les mêmes variables d'environnement (`DB_NAME`, `DB_USER`, `DB_PASSWORD`) que celles définies dans le docker-compose.

## Backup d'une base de données PostgreSQL depuis un conteneur Docker

- Exporter la base de données PostgreSQL vers un fichier SQL en utilisant la commande suivante :

    ```sh
    docker exec -t <container> pg_dump -U <utilisateur> <nom_base> > fichier.sql
    ```

    - Remplacez `<container>` par le nom ou l'ID de votre conteneur Docker PostgreSQL.
    - Remplacez `<utilisateur>` par le nom d'utilisateur PostgreSQL.
    - Remplacez `<nom_base>` par le nom de la base de données que vous souhaitez sauvegarder.
    - `fichier.sql` est le nom du fichier où la sauvegarde sera enregistrée.
- Importer la base de données depuis le fichier SQL en utilisant la commande suivante :

    ```sh
    docker exec -i <container> psql -U <utilisateur> -d <nom_base> < fichier.sql
    ```

    - Remplacez `<container>` par le nom ou l'ID de votre conteneur Docker PostgreSQL.
    - Remplacez `<utilisateur>` par le nom d'utilisateur PostgreSQL.
    - Remplacez `<nom_base>` par le nom de la base de données que vous souhaitez sauvegarder.
    - `fichier.sql` est le nom du fichier où la sauvegarde sera enregistrée.

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
