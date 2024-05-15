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

<div style="page-break-after: always;"></div>

## Table des matières

***

- [Hacking Windows 10 (et antérieur)](#hacking-windows-10-et-antérieur)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Déverrouiller le compte administrateur](#déverrouiller-le-compte-administrateur)
    - [Première méthode (Testé sur Windows 10 22h2 sur VirtualBox)](#première-méthode-testé-sur-windows-10-22h2-sur-virtualbox)
    - [Deuxième méthode (Testé sur Windows 10 22h2 sur VirtualBox)](#deuxième-méthode-testé-sur-windows-10-22h2-sur-virtualbox)

<div style="page-break-after: always;"></div>

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

***

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
