# Bonne pratique de code

## Table des matières

- [Bonne pratique de code](#bonne-pratique-de-code)
    - [Table des matières](#table-des-matières)
    - [Base de données](#base-de-données)
        - [🧭 Guide des conventions de nommage — Base de données PostgreSQL](#-guide-des-conventions-de-nommage--base-de-données-postgresql)
            - [🎯 Objectif](#-objectif)
            - [🧱 1. Règles générales](#-1-règles-générales)
            - [🧮 2. Tables](#-2-tables)
                - [Exemples :](#exemples-)
            - [🔑 3. Colonnes](#-3-colonnes)
                - [Exemple :](#exemple-)
            - [🔗 4. Clés primaires \& étrangères](#-4-clés-primaires--étrangères)
                - [Clé primaire](#clé-primaire)
                - [Clé étrangère](#clé-étrangère)
            - [🧩 5. Contraintes](#-5-contraintes)
            - [⚙️ 6. Index](#️-6-index)
            - [🔭 7. Vues](#-7-vues)
            - [🧠 8. Fonctions \& procédures](#-8-fonctions--procédures)
            - [📦 9. Séquences](#-9-séquences)
            - [🧹 10. Bonnes pratiques complémentaires](#-10-bonnes-pratiques-complémentaires)
            - [💡 Exemple complet](#-exemple-complet)
    - [API](#api)

## Base de données

- Généré par [ChatGPT](https://chat.openai.com/) non corrigé.

### 🧭 Guide des conventions de nommage — Base de données PostgreSQL

#### 🎯 Objectif

Garantir une **cohérence**, une **lisibilité** et une **interopérabilité** maximales dans la structure de la base de données, quel que soit le nombre de contributeurs.
Ces conventions s’appliquent à tous les objets SQL : **tables**, **colonnes**, **clés**, **index**, **contraintes**, **vues**, **fonctions**, etc.

---

#### 🧱 1. Règles générales

* Utiliser uniquement des **minuscules**.
    PostgreSQL convertit par défaut les identifiants non-quotés en minuscules.
* Utiliser le **snake_case** (`user_account`, `created_at`).
* Éviter les mots réservés (comme `user`, `order`, `group`).
* Tous les noms doivent être **clairs, courts et significatifs**.

---

#### 🧮 2. Tables

| Élément                | Convention                                                  | Exemple                                               |
| :--------------------- | :---------------------------------------------------------- | :---------------------------------------------------- |
| Nom                    | **snake_case**, au **pluriel**                              | `users`, `user_roles`, `order_items`                  |
| Table de liaison (n:n) | combinaison des 2 tables reliées, en ordre **alphabétique** | `product_categories` (pour `products` ↔ `categories`) |

> 💡 Les tables représentent un ensemble d’éléments → pluriel.

##### Exemples :

```sql
CREATE TABLE users (...);
CREATE TABLE orders (...);
CREATE TABLE order_items (...);
CREATE TABLE product_categories (...);
```

---

#### 🔑 3. Colonnes

* **snake_case**
* Noms explicites
* Types cohérents entre tables similaires

| Type de donnée       | Convention                    | Exemple                                  |
| :------------------- | :---------------------------- | :--------------------------------------- |
| Identifiant primaire | `id`                          | `id SERIAL PRIMARY KEY`                  |
| Clé étrangère        | `<table_singulier>_id`        | `user_id`, `order_id`                    |
| Booléen              | préfixe `is_`, `has_`, `can_` | `is_active`, `has_paid`                  |
| Date/heure           | suffixes `_at` ou `_on`       | `created_at`, `updated_at`, `deleted_at` |
| Montants             | suffixe `_amount`             | `total_amount`, `tax_amount`             |

##### Exemple :

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

---

#### 🔗 4. Clés primaires & étrangères

##### Clé primaire

* Toujours nommée `id`
* De type `SERIAL`, `BIGSERIAL` ou `UUID`

```sql
id SERIAL PRIMARY KEY
```

##### Clé étrangère

* Nom de colonne : `<table_singulier>_id`
* Nom de contrainte : `<table>_<colonne>_fkey`

```sql
ALTER TABLE orders
ADD CONSTRAINT orders_user_id_fkey
FOREIGN KEY (user_id) REFERENCES users(id);
```

---

#### 🧩 5. Contraintes

| Type          | Format                    | Exemple               |
| :------------ | :------------------------ | :-------------------- |
| Clé primaire  | `<table>_pkey`            | `users_pkey`          |
| Clé étrangère | `<table>_<colonne>_fkey`  | `orders_user_id_fkey` |
| Unique        | `<table>_<colonne>_key`   | `users_email_key`     |
| Check         | `<table>_<colonne>_check` | `users_age_check`     |

---

#### ⚙️ 6. Index

| Type           | Format                              | Exemple                         |
| :------------- | :---------------------------------- | :------------------------------ |
| Index simple   | `<table>_<colonne>_idx`             | `users_email_idx`               |
| Index multiple | `<table>_<colonne1>_<colonne2>_idx` | `orders_user_id_created_at_idx` |

```sql
CREATE INDEX users_email_idx ON users(email);
```

---

#### 🔭 7. Vues

* Nommer en **snake_case**
* Préfixer par `v_` ou `view_`
* Décrire clairement la finalité

```sql
CREATE VIEW v_user_statistics AS
SELECT u.id, u.email, COUNT(o.id) AS order_count
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id;
```

---

#### 🧠 8. Fonctions & procédures

* Utiliser des **verbes d’action** au **présent**
* En **snake_case**
* Préfixer par le domaine si nécessaire (ex : `user_`, `order_`…)

```sql
CREATE FUNCTION get_user_by_email(p_email TEXT)
RETURNS users AS $$
    SELECT * FROM users WHERE email = p_email;
$$ LANGUAGE sql;
```

---

#### 📦 9. Séquences

| Type                      | Convention       | Exemple        |
| :------------------------ | :--------------- | :------------- |
| Séquence associée à un id | `<table>_id_seq` | `users_id_seq` |

> PostgreSQL les crée automatiquement pour les colonnes `SERIAL`.

---

#### 🧹 10. Bonnes pratiques complémentaires

* Toujours inclure des colonnes `created_at` et `updated_at` dans les tables principales.
* Utiliser `deleted_at` pour la **suppression logique** (soft delete).
* Grouper les tables par **domaine fonctionnel** si le projet grossit (ex : `auth.users`, `billing.invoices` avec des **schemas** PostgreSQL).

---

#### 💡 Exemple complet

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX orders_user_id_created_at_idx ON orders(user_id, created_at);
```

## API
