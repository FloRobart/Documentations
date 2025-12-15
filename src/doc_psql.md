# Documentation Postgresql

## Table des matières

- [Documentation Postgresql](#documentation-postgresql)
  - [Table des matières](#table-des-matières)
  - [Backup d'une base de données PostgreSQL depuis un conteneur Docker](#backup-dune-base-de-données-postgresql-depuis-un-conteneur-docker)

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
