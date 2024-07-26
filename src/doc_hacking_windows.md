# Hacking Windows 10 (et antérieur)

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

- [Hacking Windows 10 (et antérieur)](#hacking-windows-10-et-antérieur)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Déverrouiller le compte administrateur](#déverrouiller-le-compte-administrateur)
    - [Première méthode (Testé sur Windows 10 22h2 sur VirtualBox)](#première-méthode-testé-sur-windows-10-22h2-sur-virtualbox)
    - [Deuxième méthode (Testé sur Windows 10 22h2 sur VirtualBox)](#deuxième-méthode-testé-sur-windows-10-22h2-sur-virtualbox)
  - [Licence](#licence)

<div class="page"></div>

## Déverrouiller le compte administrateur

### Première méthode (Testé sur Windows 10 22h2 sur VirtualBox)

- cliquer sur le bouton d'alimentation dans le coin inférieur droit, puis de maintenir la touche Maj enfoncée tout en cliquant sur le bouton Redémarrer.
- cliquer sur `'Dépannage'` > `'puis sur Options avancées'` > `'Outils de redémarrage système'`
- Cliquer sur `'Vous avez oublié votre mot de passe ou vous ne voyez pas votre compte ?'`

### Deuxième méthode (Testé sur Windows 10 22h2 sur VirtualBox)

- démarrer en mode sans échec
  - cliquer sur le bouton d'alimentation dans le coin inférieur droit, puis de maintenir la touche Maj enfoncée tout en cliquant sur le bouton Redémarrer.
  - cliquer sur `'Dépannage'` > `'puis sur Options avancées'` > `'Paramètres'`
  - Cliquer sur `'Redémarrer'`
  - Appuyer sur la touche `'f4'` pour démarrer en mode sans échec (`'fn'` + `'f4'` si `'f4'` seul ne fonctionne pas)

à partir de là, j'ai déjà accès à windows, mais je devrais refaire la manipulation à chaque fois que je veux accéder à windows. Pour palier à ce problème, je vais créer un compte administrateur.

- Ouvrir une invite de commande en tant qu'administrateur
- Créer un nouveau compte

  ```cmd
  net user /add [nom du compte] [mot de passe]
  ```

- Ajouter le compte au groupe administrateur

  ```cmd
  net localgroup administrateurs [nom du compte] /add
  ```

=================================================================================

on peux ajouter n'importe qu'elle programme dans `'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'` pour qu'il se lance au démarrage de windows

- allez dans les clés de rgistre
- modifier la clé ``
- remplacer le fichier `` par le fichier `cmd.exe`

## Licence

doc_hacking_windows.md

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
