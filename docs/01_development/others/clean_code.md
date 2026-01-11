# Documentation sur le Code Propre

## Table des Matières

- [Documentation sur le Code Propre](#documentation-sur-le-code-propre)
    - [Table des Matières](#table-des-matières)
    - [Introduction](#introduction)
    - [Les 10 règles à suivre pour un code propre](#les-10-règles-à-suivre-pour-un-code-propre)
        - [Les basiques (6 règles)](#les-basiques-6-règles)
        - [Avancé (4 règles)](#avancé-4-règles)
    - [Licence](#licence)

## Introduction

Petit guide sur les bonnes pratiques de code propre à suivre lors du développement des projets. Se guide ne sera pas très approfondi mais couvrira les bases essentielles.

## Les 10 règles à suivre pour un code propre

### Les basiques (6 règles)

1. <span style="color:green;">**Nommage Clair et explicite**</span> : Utilisez des noms de variables, fonctions et classes qui décrivent clairement leur rôle.
2. <span style="color:green;">**Commentaires Utiles**</span> : Commentez le "pourquoi" du code, pas le "quoi". Le code doit être auto-explicatif.
3. <span style="color:green;">**Fonctions Courtes**</span> : Limitez la taille des fonctions pour qu'elles fassent une seule chose et le fassent bien.
4. <span style="color:green;">**Fichiers courts**</span> : Les fichiers c'est comme les fonctions, ils doivent être courts et faire une seule chose, la différence entre un fichier et une fonction est que le fichier couvre une plus grande portée mais se limite quand même à un seul domaine, comme une fonction.
5. <span style="color:green;">**Évitez la Duplication**</span> : Ne répétez pas le même code à plusieurs endroits. Utilisez des fonctions ou des classes pour réutiliser le code.
6. <span style="color:green;">**Pas de Code Mort**</span> : Supprimez le code qui n'est plus utilisé ou nécessaire. Se qui veux également pour les imports et les getters/setters inutilisés, ça ne sert à rien d'avoir des getters/setters si ils ne sont pas utilisés.

### Avancé (4 règles)

1. <span style="color:green;">**Pas d'Abréviations**</span> : Ne pas utiliser d'abréviations. Elles nuisent à la lisibilité du code et peuvent prêter à confusion.
2. <span style="color:green;">**Style de commentaire**</span> : Utilisez un style de commentaire différent en fonction du type de commentaire. Par exemple, utilisez `//` pour les commentaires temporaire, `/* ... */` pour les commentaires utile qui vont rester dans le code et `/** ... */` pour les commentaires de documentation.
    - Dans certains cas vous pouvez également utiliser les commentaires comme des titres pour séparer les différentes parties d'un fichier, par exemple :

        ```typescript
        /*=========================*/
        /* Section 1 : Utilitaires */
        /*=========================*/
        ...

        /*---------------------------*/
        /* Section 1.1 : Utilitaires */
        /*---------------------------*/
        ...
        ```

3. <span style="color:green;">**3 Niveau d'Indentation max**</span> : Limitez le niveau d'indentation à 3 niveaux maximum. Si vous dépassez ce niveau, il est probable que votre fonction fasse trop de choses et qu'elle doive être refactorisée.
4. <span style="color:green;">**Pas de 'else'**</span> : Essayez d'éviter les `else`. Le fait d'utiliser `else` fait que vous avez deux branches dans votre code, ce qui fait deux partie de code à lire et à maintenir. Dans une fonction, il est préférable d'avoir une seule branche de code. Vous pouvez souvent remplacer un `else` par un `return` ou un `continue`. Donc quand vous écrivez une fonction, elle doit faire une chose, c'est le cas principale, tous les cas particuliers qui nécessitent un `if` sont sois ramenés au cas principale et donc pas besoins de `else`, sois il ne peuvent pas être ramené au cas principale et dans ce cas vous pouvez utiliser un `return` pour sortir de la fonction avant d'arriver au cas principale.

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
