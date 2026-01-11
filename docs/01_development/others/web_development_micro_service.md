# Developpement web d'une application sous forme de micro-service

## Table des matières

- [Developpement web d'une application sous forme de micro-service](#developpement-web-dune-application-sous-forme-de-micro-service)
    - [Table des matières](#table-des-matières)
    - [Introduction](#introduction)
    - [Base de données](#base-de-données)
    - [API (Back-end)](#api-back-end)
    - [Interface utilisateur (Front-end)](#interface-utilisateur-front-end)
    - [Deploiement et orchestration](#deploiement-et-orchestration)
    - [Licence](#licence)

## Introduction

Un micro-service est une architecture logicielle qui divise une application en petits services indépendants, chacun exécutant un processus unique et communiquant via des protocoles légers, souvent HTTP. Chaque micro-service est responsable d'une fonctionnalité spécifique de l'application globale.

Cette approche permet une plus grande flexibilité, évolutivité et facilité de maintenance par rapport aux architectures monolithiques traditionnelles. Les micro-services peuvent être développés, déployés et mis à jour indépendamment les uns des autres, ce qui facilite l'adaptation aux changements et l'intégration de nouvelles technologies.

Le développement va donc se faire en plusieurs étapes :

1. **Base de données**
2. **API (Back-end)**
3. **Interface utilisateur (Front-end)**
4. **Deploiement et orchestration**

Après ses 4 étapes nous aurons une application web complète basée sur une architecture sous forme de micro-services.

## Base de données

Pour la base de données, nous allons utiliser PostgreSQL.

[Guide PostgreSQL](../database/postgresql.md)

## API (Back-end)

Pour l'API (Back-end), nous allons utiliser Node.js avec TypeScript et le framework Express.js.

[Guide création d'une API avec TypeScript](../backend/create_api_typescript.md)

## Interface utilisateur (Front-end)

Pour l'interface utilisateur (Front-end), nous allons utiliser Flutter pour créer une application multiplateforme.

[Guide création d'une interface utilisateur avec Flutter](../frontend/flutter.md)

## Deploiement et orchestration

Pour le déploiement et l'orchestration, nous allons utiliser Docker et Docker Compose pour containeriser les différents services et faciliter leur gestion.

[Déployement d'une application avec Docker et Docker Compose](../deployment/production_with_docker.md)

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
