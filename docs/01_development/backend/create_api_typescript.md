# Création d'une API avec TypeScript

## Table des matières

- [Création d'une API avec TypeScript](#création-dune-api-avec-typescript)
    - [Table des matières](#table-des-matières)
    - [Prérequis](#prérequis)
    - [Introduction](#introduction)
    - [Création du projet](#création-du-projet)
    - [Configuration du projet](#configuration-du-projet)
    - [Architecture du projet](#architecture-du-projet)
        - [Config](#config)
        - [Core](#core)
            - [Middlewares](#middlewares)
                - [Validator Middleware](#validator-middleware)
                    - [Body Validator Middleware](#body-validator-middleware)
                    - [Params Validator Middleware](#params-validator-middleware)
                    - [Query Validator Middleware](#query-validator-middleware)
                - [Errors Middleware](#errors-middleware)
                - [Default Route Middleware](#default-route-middleware)
                - [Logger Middleware](#logger-middleware)
            - [Utils](#utils)
                - [Logger.ts](#loggerts)
            - [Models](#models)
                - [AppError model](#apperror-model)
                - [Database model](#database-model)
        - [Modules](#modules)
            - [Schema](#schema)
            - [Types](#types)
            - [Swagger](#swagger)
            - [Routes](#routes)
            - [Controller](#controller)
            - [Service](#service)
            - [Repository](#repository)
    - [Licence](#licence)

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les éléments suivants sur votre machine :

- [Node.js](https://nodejs.org/) (version 14 ou supérieure)
- [npm](https://www.npmjs.com/) (généralement inclus avec Node.js)
- Un éditeur de code, tel que [Visual Studio Code](https://code.visualstudio.com/)

## Introduction

Dans ce guide, nous allons créer une API RESTful simple en utilisant TypeScript avec le framework Express.js. Nous allons couvrir les étapes de configuration du projet, la création de routes, la gestion des requêtes et des réponses, ainsi que l'utilisation de TypeScript pour améliorer la qualité du code.

Tous les exemples de se guide sont basés sur mon API open-source : [Econoris API](https://github.com/FloRobart/Econoris_server)

## Création du projet

- créer le dossier du projet et y accéder :

    ```bash
    mkdir my-api && cd my-api
    ```

- Répondez aux questions pour initialiser le projet
    - À la question `entry point` répondez "`src/server.ts`".
- Une fois le projet initialisé, vous devriez voir un fichier `package.json` dans le répertoire du projet. Si c'est le cas, passez à l'étape suivante.

## Configuration du projet

- Les dépendances sont à installer en fonction des besoins du projet mais certaine dépendances sont quasi obligatoire pour un projet TypeScript avec Express.js afin de fonctionner correctement et d'avoir une bonne structure de code.
- **Liste des dépendances essentielles :**
    - [express](https://www.npmjs.com/package/express) : le framework web pour Node.js.
    - [zod](https://www.npmjs.com/package/zod) : pour la validation des données.
    - [dotenv](https://www.npmjs.com/package/dotenv) : pour gérer les variables d'environnement.
- **Liste des dépendances de développement essentielles :**
    - [@types/node](https://www.npmjs.com/package/@types/node) : les types TypeScript pour Node.js.
    - [@types/express](https://www.npmjs.com/package/@types/express) : les types TypeScript pour Express.js.
    - [@types/jest](https://www.npmjs.com/package/@types/jest) : les types TypeScript pour Jest.
    - [typescript](https://www.npmjs.com/package/typescript) : le compilateur TypeScript.
    - [ts-node](https://www.npmjs.com/package/ts-node) : pour exécuter des fichiers TypeScript directement.
    - [nodemon](https://www.npmjs.com/package/nodemon) : pour redémarrer automatiquement le serveur lors de modifications.
    - [jest](https://www.npmjs.com/package/jest) : le framework de test.
    - [ts-jest](https://www.npmjs.com/package/ts-jest) : pour utiliser Jest avec TypeScript.
    - [swagger-jsdoc](https://www.npmjs.com/package/swagger-jsdoc) : pour générer la documentation Swagger à partir de commentaires JSDoc.
    - [swagger-ui-express](https://www.npmjs.com/package/swagger-ui-express) : pour servir l'interface utilisateur Swagger.

- Pour installer toutes ces dépendances, exécutez les commandes suivantes :

    ```bash
    npm install express zod dotenv
    npm install --save-dev @types/node @types/express @types/jest typescript ts-node nodemon jest ts-jest swagger-jsdoc swagger-ui-express
    ```

- Dans votre `package.json`, ajoutez les scripts suivants pour faciliter le développement et les tests :

    ```json
    {
        ...
        "scripts": {
            "build": "tsc",
            "start": "node dist/server.js",
            "dev": "nodemon --watch 'src/**/*.ts' --exec 'ts-node' src/server.ts",
            "dev-docker": "docker compose -f docker-compose.dev.yml up --build",
            "clean": "rm -rf dist",
            "clean-docker": "docker compose -f docker-compose.dev.yml down --volumes --rmi all",
            "test": "jest"
        }
        ...
    }
    ```

- Après avoir installé les dépendances, vous pouvez initialiser TypeScript dans votre projet en exécutant la commande suivante :

    ```bash
    npx tsc --init
    ```

- Ajoutez ses deux lignes dans le fichier `tsconfig.json`

    ```json
    {
        "include": ["src/**/*.ts"], // Ajoutez cette ligne
        "exclude": ["node_modules", "dist", "tests", "jest.config.ts"], // Ajoutez cette ligne
        "compilerOptions": {
            ...
            "rootDir": "./src", // Décommentez cette ligne
            "outDir": "./dist", // Décommentez cette ligne
            ...
        }
    }
    ```

- Créer le fichier `jest.config.ts` à la racine du projet avec le contenu suivant :

    ```ts
    import type { Config } from 'jest';

    const config: Config = {
        preset: 'ts-jest',
        testEnvironment: 'node',

        // Emplacement des fichiers de tests
        roots: ['<rootDir>/tests/'],

        // Motif de nommage des fichiers de tests
        testRegex: ".*\\.spec\\.ts$",

        // Mappe les alias TypeScript aux chemins réels
        moduleNameMapper: {
            "^@/(.*)$": "<rootDir>/src/$1" // (@ --> src/)
        },

        // Fichier exécuté avant les tests (setup global)
        setupFilesAfterEnv: ["<rootDir>/tests/setup.ts"],

        // Options utiles
        clearMocks: true, // Réinitialise les mocks entre chaque test
        verbose: true, // Affiche des informations détaillées lors de l'exécution des tests

        // Configuration de la couverture de code
        collectCoverage: false, // Active la collecte de couverture de code
        coverageDirectory: "coverage", // Répertoire de sortie pour les rapports de couverture
        coverageReporters: ["text", "lcov"], // Formats de rapport de couverture
        collectCoverageFrom: [ // Fichiers à inclure dans la couverture
            "<rootDir>/src/**/*.ts", // Inclure tous les fichiers TypeScript dans src
            "!<rootDir>/src/app.ts", // Exclure le fichier d'entrée principal
            "!<rootDir>/src/server.ts", // Exclure les fichiers index
            "!<rootDir>/src/swagger/**", // Exclure les fichiers Swagger
            "!<rootDir>/src/config/**", // Exclure les fichiers de configuration
            "!<rootDir>/src/**/*.types.ts", // Exclure les fichiers de types
        ]
    };

    export default config;
    ```

- Créer le fichier `.dockerignore` à la racine du projet avec le contenu suivant :

    ```plaintext
    .git
    .env
    .env.*
    ```

- Créer le fichier `Dockerfile` à la racine du projet avec le contenu suivant :
    - Plus de détails sur la configuration de sécurité Docker dans le guide de déploiement : [Mise en production d'une application dockerisée](../deployment/production_with_docker.md)

    ```Dockerfile
    # Étape 1 : Build avec TypeScript
    FROM node:24-alpine AS builder
    WORKDIR /app

    # Copier le code source
    COPY tsconfig.json ./
    COPY package*.json ./
    COPY ./src ./src
    COPY ./public ./public

    # Supprimer les fichiers sensibles s'ils existent
    RUN rm -f .env* public/.env* src/.env*

    # Installer les dépendances
    RUN npm ci

    # Build TypeScript → JavaScript
    RUN npm run build

    # Étape 2 : Image finale
    FROM node:24-alpine AS runner
    WORKDIR /app

    # Copier uniquement les fichiers nécessaires à l'exécution
    COPY package*.json ./
    RUN npm ci --omit=dev

    COPY --from=builder /app/dist ./dist
    COPY --from=builder /app/public ./public

    # Ajout d'un utilisateur non-root avec UID/GID fixes
    RUN addgroup -g 1800 -S myapigroup && adduser -u 1800 -S myapiuser -G myapigroup
    USER myapiuser

    # Par défaut : lance le serveur
    CMD ["node", "dist/server.js"]
    ```

- Créer le fichier `docker-compose.yml` à la racine du projet avec le contenu suivant :
    - Plus de détails sur la configuration de sécurité Docker dans le guide de déploiement : [Mise en production d'une application dockerisée](../deployment/production_with_docker.md)

    ```yaml
    services:
        my-api:
            image: my-api:latest
            build:
                context: .
                dockerfile: Dockerfile
            restart: always
            env_file:
                - .env
            networks:
                - my-api-net
            ports:
                - ${APP_PORT:-}:80
            security_opt:
                - no-new-privileges:true
            cap_drop:
                - ALL
            cap_add:
                - NET_BIND_SERVICE
            read_only: true
            user: "1800:1800"
            tmpfs:
                - /tmp:exec,nosuid,nodev
                - /app/dist/swagger/:rw,uid=1800,gid=1800
            healthcheck:
                test: ["CMD-SHELL", "wget -q --spider http://econoris-server:80/ || exit 1"]
                interval: 10s
                timeout: 5s
                retries: 5

    volumes:
        db_data:

    networks:
        econoris-net:
            driver: bridge
    ```

- Créer le fichier `docker-compose.dev.yml` à la racine du projet avec le contenu suivant :
    - Plus de détails sur la configuration de sécurité Docker dans le guide de déploiement : [Mise en production d'une application dockerisée](../deployment/production_with_docker.md)

    ```yaml
    services:
        my-api:
            image: node:24-alpine
            working_dir: /app
            env_file: .env
            volumes:
                - ./:/app/
                - ./node_modules:/app/node_modules
            command: sh -c "cd /app && npm run dev"
            networks:
                - my-api-net
            ports:
                - ${APP_PORT}:80
            user: "1800:1800"
            tmpfs:
                - /tmp:exec,nosuid,nodev
                - /app/src/swagger/json:rw,uid=1800,gid=1800

    volumes:
        db_data:

    networks:
        api-net:
            driver: bridge
    ```

- Créer le fichier `.env` à la racine du projet avec le contenu suivant :

    ```plaintext
    APP_PORT=3000
    NODE_ENV=development
    ```

- Créer le dossier `src` à la racine du projet. C'est ici que tout le code source TypeScript de l'API sera placé.
- Créer le dossier `public` à la racine du projet. C'est ici que tous les fichiers publics (comme les icônes, etc.) seront placés.
- Créer le dossier `tests` à la racine du projet. C'est ici que tous les tests unitaires et d'intégration seront placés.

## Architecture du projet

- À ce stade, votre structure de projet devrait ressembler à ceci :

    ```txt
    my-api
    ├── node_modules # Généré par npm
    ├── public # Fichiers publics (ex: icones, etc.)
    ├── src # Code source TypeScript
    │   ├── config # Fichiers de configuration
    │   ├── core # Logique centrale de l'application
    │   ├── modules # Modules fonctionnels de l'application
    │   ├── app.ts # Point d'entrée de l'application
    │   └── server.ts # Serveur Express
    ├── tests # Tests unitaires et d'intégration
    |   ├── modules # Tests pour les modules
    |   └── setup.ts # Configuration des tests
    ├── .env # Fichier de configuration des variables d'environnement
    ├── .dockerignore # Fichier Docker ignore
    ├── Dockerfile # Fichier Docker
    ├── docker-compose.dev.yml # Fichier Docker Compose pour le développement
    ├── docker-compose.yml # Fichier Docker Compose pour la production
    ├── package.json # Fichier de configuration npm
    ├── package-lock.json # Généré par npm
    ├── jest.config.ts # Configuration de Jest
    ├── tsconfig.json # Configuration de TypeScript
    └── README.md # Présentation du projet
    ```

    - Les dossiers `tests`, `src` sont un miroir l'un de l'autre pour faciliter la navigation entre le code source et les tests associés.
- Le dossier `config` contient les fichiers de configuration de l'application, comme la configuration de la base de données, les variables d'environnement, etc.
- Le dossier `core` contient la logique centrale de l'application, comme la gestion des erreurs, la configuration de la base de données, les middlewares globaux, etc.
- Le dossier `modules` contient les différentes fonctionnalités de l'application, chaque fonctionnalité étant organisée dans son propre sous-dossier avec ses routes, contrôleurs, services et modèles.
- Le fichier `app.ts` est le point d'entrée principal de l'application où l'instance Express est créée et configurée.
- Le fichier `server.ts` est responsable du démarrage du serveur Express ainsi que de la connexion à la base de données et les possibles cron jobs.

Dans le dossier `src` nous allons opter pour une architecture modulaire par feature aussi appeler `domain-driven design (DDD)` qui permet de mieux organiser le code en regroupant les fonctionnalités par domaine métier.

### Config

Dans le dossier `config`, il y aura tous se qui concerne la configuration de l'application, au minimum il y aura un object qui contiendra les variables d'environnement inscrites dans le fichier `.env`.

- Créer le fichier `AppConfig.ts` dans le dossier `config` avec le contenu suivant :

    ```ts
    import dotenv from 'dotenv';

    dotenv.config();

    interface AppConfigInterface {
        /* Application configuration */
        readonly app_name: string;
        readonly app_port: number;
        readonly host_name: string;
        readonly base_url: string;
        readonly app_env: string;

        /* Database */
        readonly db_uri: string;

        /* CORS */
        readonly corsOptions: {
            origin: string[];
            methods: string[];
            credentials: boolean;
            allowedHeaders: string[];
        };
    }

    const config: AppConfigInterface = {
        /* Application configuration */
        app_name: "Exemple API",
        app_port: 80,
        host_name: process.env.HOST_NAME || 'localhost',
        base_url: process.env.BASE_URL || 'http://localhost:80',
        app_env: process.env.APP_ENV?.toLowerCase() || 'dev',

        /* Database */
        db_uri: `${process.env.DB_SCHEME}://${process.env.DB_USER}:${process.env.DB_PASSWORD}@${process.env.DB_HOST}:5432/${process.env.DB_NAME}`,

        /* CORS */
        corsOptions: {
            origin: (process.env.CORS_ALLOWED_ORIGINS || '').split(',').map(origin => origin.trim()),
            methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
            credentials: true,
            allowedHeaders: ['Content-Type', 'Authorization'],
        },
    };

    export default config;
    ```

### Core

Dans ce dossier `core`, il y aura tous se qui concerne la logique centrale de l'application, comme la gestion des erreurs, la configuration de la base de données, les middlewares globaux, etc.

Dans se dossier, vous pouvez créer des sous-dossiers pour organiser la logique centrale en fonction de vos besoins.

- *Les dossiers recommandés sont*
    - Middlewares
    - Utils
    - Models

#### Middlewares

Se dossier contiendra les middlewares globaux de l'application.

- Créer le dossier `middlewares` dans le dossier `core` pour y placer les middlewares globaux de l'application.
- *Les middlewares recommandés sont*
    - Validator Middleware
    - Errors Middleware
    - Default Route Middleware
    - Logger Middleware (Vous pouvez utiliser [morgan](https://www.npmjs.com/package/morgan) ou créer votre propre middleware de journalisation simple)

##### Validator Middleware

- Créer le dossier `validator` dans le dossier `middlewares` pour y placer le middleware de validation des requêtes.
- *Les validateurs recommandés sont*
    - Body Validator Middleware
    - Params Validator Middleware
    - Query Validator Middleware

###### Body Validator Middleware

- Créer le fichier `body_validator.middleware.ts` dans le dossier `validator` pour y placer le middleware de validation du corps des requêtes.
- Copier le contenu suivant dans le fichier `body_validator.middleware.ts` :

    ```ts
    import { Request, Response, NextFunction } from "express";
    import { ZodType } from "zod";
    import { AppError } from "../../models/AppError.model";

    /**
    * Middleware générique de validation du corps de la requête avec Zod.
    * @param schema Schéma Zod à utiliser pour la validation.
    * @returns Middleware Express avec req.body.validated contenant les données validées.
    * @throws AppError avec statut 400 si la validation échoue.
    */
    export const bodyValidator = (schema: ZodType) => (req: Request, _res: Response, next: NextFunction) => {
        try {
            req.body = { ...req.body, validatedData: { ...req.body.validatedData, body: schema.parse(req.body) } };
            next();
        } catch (error) {
            next(new AppError("Invalid request data", 400));
        }
    };
    ```

###### Params Validator Middleware

- Créer le fichier `params_validator.middleware.ts` dans le dossier `validator` pour y placer le middleware de validation des paramètres et des requêtes.
- Copier le contenu suivant dans le fichier `params_validator.middleware.ts` :

    ```ts
    import { Request, Response, NextFunction } from "express";
    import { ZodType } from "zod";
    import { AppError } from "../../models/AppError.model";

    /**
     * Middleware générique de validation des paramètres de la requête avec Zod.
     * @param schema Schéma Zod à utiliser pour la validation.
     * @returns Middleware Express avec req.body.validated contenant les données validées.
     * @throws AppError avec statut 400 si la validation échoue.
     */
    export const paramsValidator = (schema: ZodType) => (req: Request, _res: Response, next: NextFunction) => {
        try {
            req.body = { ...req.body, validatedData: { ...req.body.validatedData, params: schema.parse(req.params) } };
            next();
        } catch (error) {
            next(new AppError("Invalid request data", 400));
        }
    };
    ```

###### Query Validator Middleware

- Créer le fichier `query_validator.middleware.ts` dans le dossier `validator` pour y placer le middleware de validation des paramètres et des requêtes.
- Copier le contenu suivant dans le fichier `query_validator.middleware.ts` :

    ```ts
    import { Request, Response, NextFunction } from "express";
    import { ZodType } from "zod";
    import { AppError } from "../../models/AppError.model";

    /**
     * Middleware générique de validation des queries de la requête avec Zod.
     * @param schema Schéma Zod à utiliser pour la validation.
     * @returns Middleware Express avec req.body.validated contenant les données validées.
     * @throws AppError avec statut 400 si la validation échoue.
     */
    export const queryValidator = (schema: ZodType) => (req: Request, _res: Response, next: NextFunction) => {
        try {
            req.body = { ...req.body, validatedData: { ...req.body.validatedData, query: schema.parse(req.query) } };
            next();
        } catch (error) {
            next(new AppError("Invalid request data", 400));
        }
    };
    ```

##### Errors Middleware

- Créer le fichier `error.middleware.ts` dans le dossier `middlewares` pour y placer le middleware de gestion des erreurs globales.
- Copier le contenu suivant dans le fichier `error.middleware.ts` :

    ```ts
    import { Request, Response, NextFunction } from 'express';
    import { AppError } from '../models/AppError.model';

    /**
     * Middleware to handle errors.
     * @param err Error object
     * @param req Request
     * @param res Response
     * @param next NextFunction
     */
    export const errorHandler = (
        error: AppError,
        _req: Request,
        res: Response,
        _next: NextFunction
    ) => {
        res.status(error.httpStatus || 500).json(error.message || "Unknown error occurred");
    };
    ```

##### Default Route Middleware

- Créer le fichier `default_route.middleware.ts` dans le dossier `middlewares` pour y placer le middleware de route par défaut.
- Copier le contenu suivant dans le fichier `default_route.middleware.ts` :

    ```ts
    import { Request, Response, NextFunction } from 'express';
    import { AppError } from '../models/AppError.model';



    /**
     * Middleware to handle undefined routes.
     * @param req Request
     * @param res Response
     * @param next NextFunction
     */
    export const defaultRouteHandler = (_req: Request, _res: Response, next: NextFunction) => {
        next(new AppError("URL not found", 404));
    }
    ```

##### Logger Middleware

- Créer le fichier `logger.middleware.ts` dans le dossier `middlewares` pour y placer le middleware de journalisation (logger).
- Copier le contenu suivant dans le fichier `logger.middleware.ts` :

    ```ts
    import { Request, Response, NextFunction } from 'express';
    import { info } from '../utils/logger';

    /**
     * Middleware to log incoming requests.
     * @param req Request
     * @param res Response
     * @param next NextFunction
     */
    export const requestLogger = (req: Request, _res: Response, next: NextFunction) => {
        info(`Incoming request : ${req.method} ${req.url}`);
        next();
    };
    ```

#### Utils

Dans ce dossier `utils`, il y aura toutes les fonctions utilitaires réutilisables dans toute l'application.

- Créer le dossier `utils` dans le dossier `core` pour y placer les fonctions utilitaires réutilisables dans toute l'application.
- *Les utilitaires recommandés sont*
    - Logger.ts

##### Logger.ts

- Créer le fichier `logger.ts` dans le dossier `utils` pour y placer une fonction utilitaire de journalisation simple.
- Copier le contenu suivant dans le fichier `logger.ts` :

    ```ts
    import AppConfig from '../../config/AppConfig';
    import { sendErrorEmail } from '../email/error.email';



    const errorMessage   = ` [❌] ${AppConfig.app_name} - ${new Date().toISOString()} |`;
    const warningMessage = ` [⚠️] ${AppConfig.app_name} - ${new Date().toISOString()} |`;
    const successMessage = ` [✅] ${AppConfig.app_name} - ${new Date().toISOString()} |`;
    const infoMessage    = ` [❕] ${AppConfig.app_name} - ${new Date().toISOString()} |`;
    const debugMessage   = ` [🐛] ${AppConfig.app_name} - ${new Date().toISOString()} |`;



    /**
     * Logger function to log messages based on the environment level.
     * @description
     * - If APP_ENV is 0, no logs will be displayed.
     * - If APP_ENV is 1, only error logs will be displayed.
     * - If APP_ENV is 2, warning and error logs will be displayed.
     * - If APP_ENV is 3, success, warning and error logs will be displayed.
     * - If APP_ENV is 4, info, success, warning and error logs will be displayed.
     * - If APP_ENV is 5, debug, info, success, warning and error logs will be displayed.
     * @param args elements to log
     */
    export function error(...args: any[]) {
        if (!AppConfig.app_env.includes('silent')) {
            console.error(errorMessage, ...args);
        }
    }

    /**
     * Logger function to log messages based on the environment level.
     * @description
     * - If APP_ENV is 0, no logs will be displayed.
     * - If APP_ENV is 1, only error logs will be displayed.
     * - If APP_ENV is 2, warning and error logs will be displayed.
     * - If APP_ENV is 3, success, warning and error logs will be displayed.
     * - If APP_ENV is 4, info, success, warning and error logs will be displayed.
     * - If APP_ENV is 5, debug, info, success, warning and error logs will be displayed.
     * @param args elements to log
     */
    export function warning(...args: any[]) {
        if (!AppConfig.app_env.includes('silent')) {
            console.warn(warningMessage, ...args);
        }
    }

    /**
     * Logger function to log messages based on the environment level.
     * @description
     * - If APP_ENV is 0, no logs will be displayed.
     * - If APP_ENV is 1, only error logs will be displayed.
     * - If APP_ENV is 2, warning and error logs will be displayed.
     * - If APP_ENV is 3, success, warning and error logs will be displayed.
     * - If APP_ENV is 4, info, success, warning and error logs will be displayed.
     * - If APP_ENV is 5, debug, info, success, warning and error logs will be displayed.
     * @param args elements to log
     */
    export function success(...args: any[]) {
        if (!AppConfig.app_env.includes('silent')) {
            console.log(successMessage, ...args);
        }
    }

    /**
     * Logger function to log messages based on the environment level.
     * @description
     * - If APP_ENV is 0, no logs will be displayed.
     * - If APP_ENV is 1, only error logs will be displayed.
     * - If APP_ENV is 2, warning and error logs will be displayed.
     * - If APP_ENV is 3, success, warning and error logs will be displayed.
     * - If APP_ENV is 4, info, success, warning and error logs will be displayed.
     * - If APP_ENV is 5, debug, info, success, warning and error logs will be displayed.
     * @param args elements to log
     */
    export function info(...args: any[]) {
        if (!AppConfig.app_env.includes('silent')) {
            console.info(infoMessage, ...args);
        }
    }

    /**
     * Logger function to log messages based on the environment level.
     * @description
     * - If APP_ENV is 0, no logs will be displayed.
     * - If APP_ENV is 1, only error logs will be displayed.
     * - If APP_ENV is 2, warning and error logs will be displayed.
     * - If APP_ENV is 3, success, warning and error logs will be displayed.
     * - If APP_ENV is 4, info, success, warning and error logs will be displayed.
     * - If APP_ENV is 5, debug, info, success, warning and error logs will be displayed.
     * @param args elements to log
     */
    export function debug(...args: any[]) {
        if (!AppConfig.app_env.includes('silent') && AppConfig.app_env.includes('dev')) {
            console.debug(debugMessage, ...args);
        }
    }
    ```

#### Models

Dans ce dossier `models`, il y aura tous les modèles de données globaux de l'application.

- Créer le dossier `models` dans le dossier `core` pour y placer les modèles de données globaux de l'application.
- *Les modèles recommandés sont*
    - AppError.model.ts
    - Database.model.ts

##### AppError model

- Créer le fichier `AppError.model.ts` dans le dossier `models` pour y placer le modèle de gestion des erreurs personnalisées.
- Copier le contenu suivant dans le fichier `AppError.model.ts` :

    ```ts
    /**
     * Custom Error interface to include HTTP status codes
     * @param message Error message
     * @param httpStatus HTTP status code
     */
    export class AppError extends Error {
        httpStatus: number;

        constructor(message: string = "Internal Server Error", httpStatus: number = 500) {
            super(message);
            this.httpStatus = httpStatus;
        }
    }
    ```

##### Database model

- Créer le fichier `Database.model.ts` dans le dossier `models` pour y placer le modèle de configuration de la base de données.
- Copier le contenu suivant dans le fichier `Database.model.ts` :

    ```ts
    import pg from 'pg';
    import * as logger from "../utils/logger";
    import { AppError } from './AppError.model';



    /*=========================*/
    /* Abstract Database Model */
    /*=========================*/
    /**
     * Database schema defining the IDatabase interface and Query type.
     */
    export interface IDatabase {
        connect(): Promise<void>;
        close(): Promise<void>;
    }

    /**
     * Query type representing a database query with text and optional values.
     */
    export type Query = {
        text: string;
        values: (string | number | boolean | null)[] | undefined;
    };

    /**
     * Abstract Database class implementing the IDatabase interface.
     * This class provides methods to connect to, close, and execute queries on the database.
     * @abstract
     * @implements {IDatabase}
     * @method connect - Connects to the database.
     * @method close - Closes the database connection.
     * @method static execute - Executes a query on the database.
     */
    export abstract class ADatabase implements IDatabase {
        protected static client: pg.Client | null = null;

        abstract connect(): Promise<void>;
        abstract close(): Promise<void>;

        /**
         * Executes a query on the database
         * @async
         * @param query The query to execute
         * @returns Array of rows returned by the query or an empty array if no rows are returned or an error occurs
         * @throws AppError if the database is not connected or if the query fails
         */
        static async execute<T = any>(query: Query): Promise<T[]> {
            try {
                if (!this.client) throw new AppError('Database not connected');
                const res = await this.client.query(query.text, query.values);
                if (res.rows === null) { throw new AppError('Database query failed'); }

                return res.rows || [];
            } catch (error) {
                throw (error instanceof AppError) ? error : new AppError("Database unknown error");
            }
        }
    }



    /*================*/
    /* Database Model */
    /*================*/
    /**
     * Database class to manage PostgreSQL connections and queries.
     * @extends ADatabase
     * @method connect - Connects to the database.
     * @method close - Closes the database connection.
     * @method static execute - Executes a query on the database.
     * @example
     * const db = new Database('postgresql://user:password@localhost:5432/mydb');
     * const rows = await Database.execute({ text: 'SELECT * FROM mytable', values: [] });
     */
    export class Database extends ADatabase {
        constructor(private dburi: string | object) { super(); }

        /**
         * Connects the server to the database
         * @async
         * @param dburi The database URI
         * @example dburi = "postgresql://<user>:<password>@<host>:<port>/<db_name>"
         * @returns true if connected successfully, otherwise false
         */
        async connect(): Promise<void> {
            try {
                if (Database.client) return;
                Database.client = new pg.Client(this.dburi);
                await Database.client.connect();
                Database.client.on('error', (error: Error) => logger.error('DATABASE ERROR :', error));
                Database.client.on('end', () => logger.info('DATABASE CONNECTION CLOSED'));
            } catch (error) {
                throw new AppError('Database connection failed');
            }
        }

        /**
         * Closes the database connection
         * @async
         * @returns boolean true if the connection was closed successfully, otherwise false
         */
        async close(): Promise<void> {
            try {
                if (!Database.client) return;
                await Database.client.end();
                Database.client = null;
            } catch (error) {
                throw new AppError('Database disconnection failed');
            }
        }
    }
    ```

### Modules

Dans ce dossier `modules`, il y aura toutes les fonctionnalités de l'application, chaque fonctionnalité étant organisée dans son propre sous-dossier avec ses routes, contrôleurs, services et modèles.

Voici l'architecture recommandée pour chaque module :

```txt
example_module
├── example_module.schema.ts     # Représente les schémas de validation Zod pour le module
├── example_module.types.ts      # Définit les types TypeScript spécifiques au module (à l'aide de z.infer(<ZodSchema>))
├── example_module.swagger.ts    # Définit la documentation Swagger pour le module
├── example_module.routes.ts     # URI routes pour le module avec les middlewares associés (validators, puis appel du controller)
├── example_module.controller.ts # Récupère les données de la requête, appelle le service approprié, puis renvoie la réponse au client
├── example_module.service.ts    # Contient la logique métier principale du module
└── example_module.repository.ts # Gère l'accès aux données et les opérations CRUD pour le module
```

Vous trouverez ci-dessous une brève description de chaque fichier ainsi que des exemples de contenu pour un module fictif appelé `operations` et qui gère des opérations financières basiques.

#### Schema

Le fichier `operations.schema.ts` représente les schémas de validation Zod pour le module `operations`.

```ts
import { z, ZodDate, ZodNumber } from "zod";



/*========*/
/* SELECT */
/*========*/
export const OperationsSchema = z.object({
    id: z.int().min(1),
    levy_date: z.date().default(new Date()),
    label: z.string().trim().min(1).max(255),
    amount: z.number(),
    category: z.string().trim().min(1).max(255),

    source: z.string().trim().max(255).nullable().default(null),
    destination: z.string().trim().max(255).nullable().default(null),
    costs: z.number().default(0.0),
    is_validate: z.boolean().default(false),

    user_id: z.int().min(1),
    subscription_id: z.int().min(1).nullable().default(null),

    created_at: z.date().readonly(),
    updated_at: z.date().readonly(),
});



/*========*/
/* INSERT */
/*========*/
export const OperationsInsertSchema = OperationsSchema.extend({
    user_id: OperationsSchema.shape.user_id.optional(),
    levy_date: z.preprocess<unknown, ZodDate>(
        (val) => typeof val === "string" ? new Date(val) : val,
        z.date(),
    ),
}).omit({
    id: true,

    created_at: true,
    updated_at: true,
});



/*========*/
/* UPDATE */
/*========*/
export const OperationsIdUpdateSchema = z.object({
    id: z.preprocess<unknown, ZodNumber>(
        (val) => typeof val === "string" ? Number(val.trim()) : val,
        z.int().min(1),
    ),
});

export const OperationsUpdateSchema = OperationsInsertSchema.extend({
    id: OperationsSchema.shape.id,
});



/*========*/
/* DELETE */
/*========*/
export const OperationsIdDeleteSchema = OperationsIdUpdateSchema;
```

#### Types

Le fichier `operations.types.ts` définit les types TypeScript spécifiques au module. Notez l'utilisation de `z.infer(<ZodSchema>)` pour générer automatiquement les types à partir des schémas Zod définis dans le fichier `operations.schema.ts`.

```ts
import { z } from "zod";
import { OperationsSchema, OperationsInsertSchema, OperationsUpdateSchema, OperationsIdUpdateSchema, OperationsIdDeleteSchema } from "./operations.schema";


/* SELECT */
export type Operation = z.infer<typeof OperationsSchema>;

/* INSERT */
export type OperationInsert = z.infer<typeof OperationsInsertSchema>;

/* UPDATE */
export type OperationsIdUpdate = z.infer<typeof OperationsIdUpdateSchema>;
export type OperationUpdate = z.infer<typeof OperationsUpdateSchema>;

/* DELETE */
export type OperationsIdDelete = z.infer<typeof OperationsIdDeleteSchema>;
```

#### Swagger

Le fichier `operations.swagger.ts` définit la documentation Swagger pour le module. Se sont simplement des commentaires qui permettront de générer automatiquement une documentation interactive pour l'API.

```ts
/*========*/
/* SELECT */
/*========*/
/**
 * @swagger
 * components:
 *   schemas:
 *     Operations:
 *       type: object
 *       required:
 *         - id
 *         - levy_date
 *         - label
 *         - amount
 *         - category
 *         - source
 *         - destination
 *         - costs
 *         - is_validate
 *         - user_id
 *         - subscription_id
 *         - created_at
 *         - updated_at
 *       properties:
 *         id:
 *           type: number
 *           exemple: 1
 *         levy_date:
 *           type: string
 *           exemple: "2024-01-01T00:00:00.000Z"
 *         label:
 *           type: string
 *           exemple: "Sample Operation"
 *         amount:
 *           type: number
 *           exemple: 100.00
 *         category:
 *           type: string
 *           exemple: "Income"
 *         source:
 *           type: string
 *           exemple: "Job"
 *         destination:
 *           type: string
 *           exemple: "Bank"
 *         costs:
 *           type: number
 *           exemple: 2.50
 *         is_validate:
 *           type: boolean
 *           exemple: true
 *         user_id:
 *           type: number
 *           exemple: 1
 *         subscription_id:
 *           type: number|null
 *           exemple: 1
 *         created_at:
 *           type: string
 *           exemple: "2024-01-01T00:00:00.000Z"
 *         updated_at:
 *           type: string
 *           exemple: "2024-01-01T00:00:00.000Z"
 */


/*========*/
/* INSERT */
/*========*/
/**
 * @swagger
 * components:
 *   schemas:
 *     OperationsInsert:
 *       type: object
 *       required:
 *         - levy_date
 *         - label
 *         - amount
 *         - category
 *       properties:
 *         levy_date:
 *           type: string
 *           exemple: "2024-01-01T00:00:00.000Z"
 *         label:
 *           type: string
 *           exemple: "Sample Operation"
 *         amount:
 *           type: number
 *           exemple: 100.00
 *         category:
 *           type: string
 *           exemple: "Income"
 *         source:
 *           type: string
 *           exemple: "Job"
 *         destination:
 *           type: string
 *           exemple: "Bank"
 *         costs:
 *           type: number
 *           exemple: 2.50
 *         is_validate:
 *           type: boolean
 *           exemple: true
 */


/*========*/
/* UPDATE */
/*========*/
/**
 * @swagger
 * components:
 *   schemas:
 *     OperationsUpdate:
 *       type: object
 *       required:
 *         - levy_date
 *         - label
 *         - amount
 *         - category
 *         - source
 *         - destination
 *         - costs
 *         - is_validate
 *       properties:
 *         levy_date:
 *           type: string
 *           exemple: "2024-01-01T00:00:00.000Z"
 *         label:
 *           type: string
 *           exemple: "Sample Operation"
 *         amount:
 *           type: number
 *           exemple: 100.00
 *         category:
 *           type: string
 *           exemple: "Income"
 *         source:
 *           type: string
 *           exemple: "Job"
 *         destination:
 *           type: string
 *           exemple: "Bank"
 *         costs:
 *           type: number
 *           exemple: 2.50
 *         is_validate:
 *           type: boolean
 *           exemple: true
 */
```

#### Routes

Le fichier `operations.routes.ts` définit les URI routes pour le module avec les middlewares associés (validators, puis appel du controller). Dans se fichier ont aura à la fois les routes ainsi que les commentaires Swagger pour documenter chaque endpoint.

Vous noterez l'utilisation des middlewares de validation du corps, des paramètres et des requêtes avant d'appeler les contrôleurs appropriés.

```ts
import { Router } from "express";
import * as OperationsController from "./operations.controller";
import { bodyValidator } from "../../core/middlewares/validators/body_validator.middleware";
import { OperationsIdDeleteSchema, OperationsIdUpdateSchema, OperationsInsertSchema, OperationsUpdateSchema } from "./operations.schema";
import { paramsQueryValidator } from "../../core/middlewares/validators/params_query_validator.middleware";

const router = Router();

/*========*/
/* SELECT */
/*========*/
/**
 * @swagger
 * /operations:
 *   get:
 *     tags:
 *       - Operations
 *     summary: Retrieve a list of operations of the authenticated user
 *     description: Retrieve a list of operations associated with the authenticated user.
 *     parameters:
 *       - in: headers
 *         name: Authorization
 *         required: true
 *         schema:
 *           type: string
 *           example: "Bearer <token>"
 *     responses:
 *       200:
 *         description: A list of operations
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Operations'
 *       204:
 *         description: No content. No operations found.
 *       401:
 *         description: Unauthorized access.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error401'
 *       500:
 *         description: Internal server error. Please create an issue on Github
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error500'
 */
router.get('/', OperationsController.selectOperations);


/*========*/
/* INSERT */
/*========*/
/**
 * @swagger
 * /operations:
 *   post:
 *     tags:
 *       - Operations
 *     summary: Create a new operation for the authenticated user
 *     description: Create a new operation associated with the authenticated user.
 *     parameters:
 *       - in: headers
 *         name: Authorization
 *         required: true
 *         schema:
 *           type: string
 *           example: "Bearer <token>"
 *       - in: body
 *         name: operation
 *         required: true
 *         description: Operation object that needs to be added
 *         schema:
 *           $ref: '#/components/schemas/OperationsInsert'
 *     responses:
 *       201:
 *         description: Created operation
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Operations'
 *       400:
 *         description: Bad request. Please check the input data.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error400'
 *       401:
 *         description: Unauthorized access.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error401'
 *       500:
 *         description: Internal server error. Please create an issue on Github
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error500'
 */
router.post('/', bodyValidator(OperationsInsertSchema), OperationsController.insertOperations);


/*========*/
/* UPDATE */
/*========*/
/**
 * @swagger
 * /operations:
 *   put:
 *     tags:
 *       - Operations
 *     summary: Update an existing operation for the authenticated user
 *     description: Update an existing operation associated with the authenticated user.
 *     parameters:
 *       - in: headers
 *         name: Authorization
 *         required: true
 *         schema:
 *           type: string
 *           example: "Bearer <token>"
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *           example: 1
 *       - in: body
 *         name: operation
 *         required: true
 *         description: Operation object that needs to be updated
 *         schema:
 *           $ref: '#/components/schemas/OperationsUpdate'
 *     responses:
 *       200:
 *         description: Updated operation
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Operations'
 *       400:
 *         description: Bad request. Please check the input data.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error400'
 *       401:
 *         description: Unauthorized access.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error401'
 *       500:
 *         description: Internal server error. Please create an issue on Github
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error500'
 */
router.put('/:id', paramsQueryValidator(OperationsIdUpdateSchema), bodyValidator(OperationsUpdateSchema), OperationsController.updateOperations);


/*========*/
/* DELETE */
/*========*/
/**
 * @swagger
 * /operations:
 *   delete:
 *     tags:
 *       - Operations
 *     summary: Delete an existing operation for the authenticated user
 *     description: Delete an existing operation associated with the authenticated user.
 *     parameters:
 *       - in: headers
 *         name: Authorization
 *         required: true
 *         schema:
 *           type: string
 *           example: "Bearer <token>"
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *           example: 1
 *     responses:
 *       200:
 *         description: Deleted operation
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Operations'
 *       400:
 *         description: Bad request. Please check the input data.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error400'
 *       401:
 *         description: Unauthorized access.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error401'
 *       500:
 *         description: Internal server error. Please create an issue on Github
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/error500'
 */
router.delete('/:id', paramsQueryValidator(OperationsIdDeleteSchema), OperationsController.deleteOperations);

export default router;
```

#### Controller

Le fichier `Operations.controller.ts` récupère les données de la requête, appelle le service approprié, puis renvoie la réponse au client

```ts
import { Request, Response, NextFunction } from 'express';
import * as OperationsService from './operations.service';
import { OperationInsert, OperationUpdate } from './operations.types';



/*========*/
/* SELECT */
/*========*/
/**
 * Get all operations for a user.
 * @param req.body.user The user object containing the user ID.
 * @param res The response object.
 * @param next The next middleware function.
 */
export const selectOperations = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const userId: number = req.body.user.id;

        const operations = await OperationsService.selectOperations(userId);
        res.status(operations.length ? 200 : 204).json(operations);
    } catch (error) {
        next(error);
    }
};


/*========*/
/* INSERT */
/*========*/
/**
 * Insert a new operation for a user.
 * @param req.body.user The user object containing the user ID.
 * @param req.body.validatedData.body The validated operation data to insert.
 * @param res The response object.
 * @param next The next middleware function.
 */
export const insertOperations = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const operationData: OperationInsert = { ...req.body.validatedData.body, user_id: req.body.user.id };

        const newOperation = await OperationsService.insertOperations(operationData);
        res.status(201).json(newOperation);
    } catch (error) {
        next(error);
    }
};


/*========*/
/* UPDATE */
/*========*/
/**
 * Update an existing operation for a user.
 * @param req.body.user The user object containing the user ID.
 * @param req.body.validatedData.body The validated operation data to update.
 * @param res The response object.
 * @param next The next middleware function.
 */
export const updateOperations = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const operationData: OperationUpdate = { ...req.body.validatedData.body, id: req.body.validatedData.params.id, user_id: req.body.user.id };

        const operations = await OperationsService.updateOperations(operationData);
        res.status(200).json(operations);
    } catch (error) {
        next(error);
    }
};


/*========*/
/* DELETE */
/*========*/
/**
 * Delete an operation for a user.
 * @param req.body.user The user object containing the user ID.
 * @param req.body.validatedData.params.id The ID of the operation to delete.
 * @param res The response object.
 * @param next The next middleware function.
 */
export const deleteOperations = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const userId: number = req.body.user.id;
        const operationId: number = req.body.validatedData.params.id;

        const operations = await OperationsService.deleteOperations(userId, operationId);
        res.status(200).json(operations);
    } catch (error) {
        next(error);
    }
};
```

#### Service

Le fichier `operations.service.ts` contient la logique métier principale du module. Se fichier peut être plus ou moins complexe en fonction des besoins métier.

```ts
import { Operation, OperationInsert, OperationUpdate } from './operations.types';
import * as OperationsRepository from './operations.repository';
import { OperationsInsertSchema, OperationsSchema, OperationsUpdateSchema } from './operations.schema';
import { ZodError } from 'zod';
import { AppError } from '../../core/models/AppError.model';
import { addDays, addWeeks, addMonths, isAfter, endOfMonth } from 'date-fns';
import { updateSubscriptionsLastGeneratedAt } from '../subscriptions/subscriptions.service';
import { Subscription } from '../subscriptions/subscriptions.types';
import { SubscriptionsSchema } from '../subscriptions/subscriptions.schema';



/*========*/
/* SELECT */
/*========*/
/**
 * Get all operations for a user.
 * @param userId The ID of the user.
 * @returns An array of Operation objects.
 * @throws AppError if there is an issue retrieving the operations.
 */
export async function selectOperations(userId: number): Promise<Operation[]> {
    try {
        const operations = await OperationsRepository.selectOperations(userId);
        return OperationsSchema.array().parse(operations);
    } catch (error) {
        throw (error instanceof ZodError) ? new AppError("Failed to parse operations", 500) : error;
    }
}

/**
 * Get all invalid operations.
 * @returns An array of Operation objects.
 * @throws AppError if there is an issue retrieving the operations.
 */
export async function selectAllOperationsInvalidate(): Promise<Operation[]> {
    try {
        const operations = await OperationsRepository.selectAllOperationsInvalidate();
        return OperationsSchema.array().parse(operations);
    } catch (error) {
        throw (error instanceof ZodError) ? new AppError("Failed to parse operations", 500) : error;
    }
}


/*========*/
/* INSERT */
/*========*/
/**
 * Insert a new operation for a user.
 * @param operationData The operation data to insert.
 * @returns The newly created Operation object.
 * @throws AppError if there is an issue inserting the operation.
 */
export async function insertOperations(operationData: OperationInsert): Promise<Operation> {
    try {
        const operations = await OperationsRepository.insertOperations(operationData);
        return OperationsSchema.parse(operations);
    } catch (error) {
        throw (error instanceof ZodError) ? new AppError("Failed to parse operation (operation inserted successfully)", 500) : error;
    }
}

/**
 * Insert multiple operations for a user in bulk.
 * @param operations The array of operation data to insert.
 * @throws AppError if there is an issue inserting the operations.
 */
export async function insertBulkOperations(operationsData: OperationInsert[]): Promise<void> {
    if (operationsData.length === 0) return;

    try {
        const operations: OperationInsert[] = OperationsInsertSchema.array().parse(operationsData);

        const chunkSize = 500;
        if (operations.length > chunkSize) {
            const chunks: OperationInsert[][] = [];
            for (let i = 0; i < operations.length; i += chunkSize) {
                chunks.push(operations.slice(i, i + chunkSize));
            }
            await Promise.all(chunks.map((chunk: OperationInsert[]) => OperationsRepository.insertBulkOperations(chunk)));
            return;
        }

        await OperationsRepository.insertBulkOperations(operations);
    } catch (error) {
        throw (error instanceof ZodError) ? new AppError("Failed to parse operations bulk", 500) : error;
    }
}

/**
 * Generate missing operations for a subscription up to the current date.
 * @param subscription The subscription object.
 * @throws AppError if there is an issue generating the operations.
 */
export async function insertMissingOperations(subscription: Subscription): Promise<void> {
    let parsedSubscription: Subscription;
    try {
        parsedSubscription = SubscriptionsSchema.parse(subscription);
    } catch (error) {
        throw new AppError("Failed to parse subscription", 500);
    }

    try {
        const operationsToInsert: OperationInsert[] = [];

        let currentDate: Date = parsedSubscription.last_generated_at ?? parsedSubscription.start_date;
        const now: Date = new Date();

        const endOfCurrentMonth: Date = endOfMonth(now);

        // Ajout de l'opération pour le mois de début si aucune opération n'a encore été générée
        if (!parsedSubscription.last_generated_at) {
            let is_validate = currentDate <= now;
            operationsToInsert.push({
                levy_date: currentDate,
                label: parsedSubscription.label,
                amount: parsedSubscription.amount,
                category: parsedSubscription.category,
                source: parsedSubscription.source,
                destination: parsedSubscription.destination,
                costs: parsedSubscription.costs,
                is_validate,
                subscription_id: parsedSubscription.id,
                user_id: parsedSubscription.user_id,
            });
        }

        while (true) {
            let nextDate = getNextDate(currentDate, parsedSubscription.interval_unit, parsedSubscription.interval_value);

            if (parsedSubscription.interval_unit === 'months' && parsedSubscription.day_of_month) {
                nextDate.setDate(parsedSubscription.day_of_month);
            }

            if (parsedSubscription.end_date && isAfter(nextDate, parsedSubscription.end_date)) break;
            if (isAfter(nextDate, endOfCurrentMonth)) break;

            let is_validate = nextDate <= now;
            operationsToInsert.push({
                levy_date: nextDate,
                label: parsedSubscription.label,
                amount: parsedSubscription.amount,
                category: parsedSubscription.category,
                source: parsedSubscription.source,
                destination: parsedSubscription.destination,
                costs: parsedSubscription.costs,
                is_validate,
                subscription_id: parsedSubscription.id,
                user_id: parsedSubscription.user_id,
            });

            currentDate = nextDate;
        }

        if (operationsToInsert.length > 0) {
            await insertBulkOperations(operationsToInsert);
            await updateSubscriptionsLastGeneratedAt(parsedSubscription.id, currentDate);
        }
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to generate missing operations", 500);
    }
}


/*========*/
/* UPDATE */
/*========*/
/**
 * Update an existing operation for a user.
 * @param operationData The operation data to update.
 * @returns The updated Operation object.
 */
export async function updateOperations(operationData: OperationUpdate): Promise<Operation> {
    try {
        const operations = await OperationsRepository.updateOperations(operationData);
        return OperationsSchema.parse(operations);
    } catch (error) {
        throw (error instanceof ZodError) ? new AppError("Failed to parse operation (operation updated successfully)", 500) : error;
    }
}

/**
 * Update multiple operations validate status in bulk.
 * @param operations The array of operation data to update.
 * @param isValidate The validate status to set.
 * @throws AppError if there is an issue updating the operations.
 */
export async function updateBulkOperationsValidate(operations: OperationUpdate[], isValidate: boolean): Promise<void> {
    try {
        const parsedOperations = OperationsUpdateSchema.array().parse(operations);

        const chunkSize = 500;
        if (parsedOperations.length > chunkSize) {
            const chunks: OperationUpdate[][] = [];
            for (let i = 0; i < parsedOperations.length; i += chunkSize) {
                chunks.push(parsedOperations.slice(i, i + chunkSize));
            }
            await Promise.all(chunks.map((chunk: OperationUpdate[]) => OperationsRepository.updateBulkOperationsValidate(chunk, isValidate)));
            return;
        }

        await OperationsRepository.updateBulkOperationsValidate(parsedOperations, isValidate);
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to update operations validate status", 500);
    }
}


/*========*/
/* DELETE */
/*========*/
/**
 * Delete an operation for a user.
 * @param userId The ID of the user.
 * @param operationId The ID of the operation to delete.
 * @returns The deleted Operation object.
 * @throws AppError if there is an issue deleting the operation.
 */
export async function deleteOperations(userId: number, operationId: number): Promise<Operation> {
    try {
        const operations = await OperationsRepository.deleteOperations(userId, operationId);
        return OperationsSchema.parse(operations);
    } catch (error) {
        throw (error instanceof ZodError) ? new AppError("Failed to parse operation (operation deleted successfully)", 500) : error;
    }
}


/*===========*/
/* UTILITIES */
/*===========*/
/**
 * Get the next date based on the current date, interval unit, and value.
 * @param current Current date
 * @param unit Interval unit ('days', 'weeks', 'months')
 * @param value Interval value
 * @returns The next date
 * @throws AppError if the interval unit is unsupported
 */
function getNextDate(current: Date, unit: string, value: number): Date {
    switch (unit) {
        case 'days':
            return addDays(current, value);
        case 'weeks':
            return addWeeks(current, value);
        case 'months':
            return addMonths(current, value);
        default:
            throw new AppError(`Unsupported interval unit : ${unit}`, 400);
    }
}
```

#### Repository

Le fichier `operations.repository.ts` gère l'accès aux données et les opérations CRUD pour le module. Si les données sont stockées dans une base de données, ce fichier contiendra les requêtes SQL nécessaires pour interagir avec la base de données, sinon, ce fichier contiendra la logique pour interagir avec le système de stockage de données choisi.

```ts
import { AppError } from "../../core/models/AppError.model";
import { Database } from "../../core/models/Database.model";
import { Operation, OperationInsert, OperationUpdate } from "./operations.types";



/*========*/
/* SELECT */
/*========*/
/**
 * Get all operations for a user.
 * @param userId The ID of the user.
 * @returns An array of Operation objects.
 * @throws AppError if there is an issue retrieving the operations.
 */
export async function selectOperations(userId: number): Promise<Operation[]> {
    try {
        let query = "SELECT * FROM operations WHERE user_id = $1;";
        let values = [userId];

        const operations = await Database.execute<Operation>({ text: query, values: values });

        /* Automatic conversion of amount and costs fields to Number */
        operations.forEach(op => {
            if (typeof op.amount === 'string') op.amount = Number(op.amount);
            if (typeof op.costs === 'string') op.costs = Number(op.costs);
        });

        return operations
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to retrieve operations", 500);
    }
}

/**
 * Get all invalid operations.
 * @returns An array of Operation objects.
 * @throws AppError if there is an issue retrieving the operations.
 */
export async function selectAllOperationsInvalidate(): Promise<Operation[]> {
    try {
        const query = "SELECT * FROM operations WHERE is_validate = false AND levy_date <= CURRENT_DATE;";

        const operations = await Database.execute<Operation>({ text: query, values: [] });

        /* Automatic conversion of amount and costs fields to Number */
        operations.forEach(op => {
            if (typeof op.amount === 'string') op.amount = Number(op.amount);
            if (typeof op.costs === 'string') op.costs = Number(op.costs);
        });

        return operations;
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to retrieve invalid operations", 500);
    }
}


/*========*/
/* INSERT */
/*========*/
/**
 * Insert a new operation for a user.
 * @param operationData The operation data to insert.
 * @returns The newly created Operation object.
 * @throws AppError if there is an issue inserting the operation.
 */
export async function insertOperations(operationData: OperationInsert): Promise<Operation> {
    try {
        const keys = Object.keys(operationData);
        const columns = keys.join(", ");
        const placeholders = keys.map((_, i) => `$${i + 1}`).join(", ");

        const values = keys.map(key => (operationData as any)[key]);
        const query = `INSERT INTO operations (${columns}) VALUES (${placeholders}) RETURNING *;`;

        const rows = await Database.execute<Operation>({ text: query, values: values });
        if (rows.length === 0) { throw new AppError("No operation inserted", 500); }

        /* Automatic conversion of amount and costs fields to Number */
        const result = { ...rows[0] };
        if (typeof result.amount === 'string') result.amount = Number(result.amount);
        if (typeof result.costs === 'string') result.costs = Number(result.costs);

        return result;
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to insert operations", 500);
    }
}

/**
 * Insert multiple operations for a user in bulk.
 * @param operations The array of operation data to insert.
 * @returns void
 * @throws AppError if there is an issue inserting the operations.
 */
export async function insertBulkOperations(operations: OperationInsert[]): Promise<void> {
    if (operations.length === 0) return;

    try {
        const keys = Object.keys(operations[0]);
        const columns = keys.join(", ");
        let query = `INSERT INTO operations (${columns}) VALUES `;
        const values: any[] = [];

        let valueIndex = 1;
        for (const operation of operations) {
            const placeholders = keys.map((_, i) => `$${valueIndex++}`).join(", ");
            query += `(${placeholders}), `;
            values.push(...keys.map(key => (operation as any)[key]));
        }

        query = query.slice(0, -2) + ";";
        await Database.execute({ text: query, values });
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to insert bulk operations", 500);
    }
}


/*========*/
/* UPDATE */
/*========*/
/**
 * Update an existing operation for a user.
 * @param operationData The operation data to update.
 * @returns The updated Operation object.
 */
export async function updateOperations(operationData: OperationUpdate): Promise<Operation> {
    try {
        /* Extract id and user_id, prepare fields to update */
        const { id, user_id, ...fieldsToUpdate } = operationData;
        const keys = Object.keys(fieldsToUpdate);

        if (!id || !user_id || keys.length === 0) {
            throw new AppError("Missing data to update", 400);
        }

        /* Build SET clause and values */
        const setClause = keys.map((key, i) => `${key} = $${i + 1}`).join(", ");
        const values = keys.map(key => (fieldsToUpdate as any)[key]);

        /* Append id and user_id to values for WHERE clause */
        const query = `UPDATE operations SET ${setClause} WHERE id = $${values.length + 1} AND user_id = $${values.length + 2} RETURNING *;`;
        values.push(id, user_id);

        /* Execute query */
        const rows = await Database.execute<Operation>({ text: query, values });
        if (rows.length === 0) { throw new AppError("No operation updated", 404); }

        /* Automatic conversion of amount and costs fields to Number */
        const result = { ...rows[0] };
        if (typeof result.amount === 'string') result.amount = Number(result.amount);
        if (typeof result.costs === 'string') result.costs = Number(result.costs);

        return result;
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to update operations", 500);
    }
}

/**
 * Update multiple operations validate status in bulk.
 * @param operations The array of operation data to update.
 * @param isValidate The validate status to set.
 * @throws AppError if there is an issue updating the operations.
 */
export async function updateBulkOperationsValidate(operations: OperationUpdate[], isValidate: boolean): Promise<void> {
    try {
        const query = "UPDATE operations SET is_validate = $1 WHERE ";
        const values: any[] = [isValidate];

        const conditions = operations.map<string>((operation, _index) => {
            values.push(operation.id, operation.user_id);
            return `(id = $${values.length - 1} AND user_id = $${values.length})`;
        }).join(" OR ");

        const finalQuery = query + conditions + ";";
        await Database.execute({ text: finalQuery, values });
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to update operations validate status", 500);
    }
}


/*========*/
/* DELETE */
/*========*/
/**
 * Delete an operation for a user.
 * @param userId The ID of the user.
 * @param operationId The ID of the operation to delete.
 * @returns The deleted Operation object.
 * @throws AppError if there is an issue deleting the operation.
 */
export async function deleteOperations(userId: number, operationId: number): Promise<Operation> {
    try {
        const query = `DELETE FROM operations WHERE id = $1 AND user_id = $2 RETURNING *;`;
        const values = [operationId, userId];

        const rows = await Database.execute<Operation>({ text: query, values });
        if (rows.length === 0) { throw new AppError("No operation deleted", 404); }

        /* Automatic conversion of amount and costs fields to Number */
        const result = { ...rows[0] };
        if (typeof result.amount === 'string') result.amount = Number(result.amount);
        if (typeof result.costs === 'string') result.costs = Number(result.costs);

        return result;
    } catch (error) {
        throw (error instanceof AppError) ? error : new AppError("Failed to delete operations", 500);
    }
}
```

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
