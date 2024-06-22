# Documentation de Visual Studio Code

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

- [Documentation de Visual Studio Code](#documentation-de-visual-studio-code)
  - [Règles](#règles)
  - [Table des matières](#table-des-matières)
  - [Installation de Visual Studio code - Linux](#installation-de-visual-studio-code---linux)
    - [Avec un fichier deb (recommandé)](#avec-un-fichier-deb-recommandé)
    - [Avec le dépot snap](#avec-le-dépot-snap)
  - [Installation de mon thème personnalisé pour vscode - Linux](#installation-de-mon-thème-personnalisé-pour-vscode---linux)
    - [Avec le script d'installation](#avec-le-script-dinstallation)
    - [Manuellement](#manuellement)
  - [Configuration de VS Code et des ses extensions](#configuration-de-vs-code-et-des-ses-extensions)
    - [Header et footer de l'extension `Markdown PDF` de vs code](#header-et-footer-de-lextension-markdown-pdf-de-vs-code)

<div class="page"></div>

## Installation de Visual Studio code - Linux

### Avec un fichier deb (recommandé)

- Télecharger le fichier deb de la dernière version sur :

> <https://code.visualstudio.com/download>

- Executer le fichier deb

  ```shell
  sudo dpkg -i code_*_amd64.deb
  ```

### Avec le dépot snap

- Installer le paquet du dépot `snap` :

  ```shell
  sudo snap install code --classic
  ```

## Installation de mon thème personnalisé pour vscode - Linux

### Avec le script d'installation

- Cloner le repertoire Github :
  - Clone avec HTTPS

    ```shell
    git clone https://github.com/FloRobart/Themes_for_vsCode.git
    ```

  - Clone avec SSH

    ```shell
    git clone git@github.com:FloRobart/Themes_for_vsCode.git
    ```

- Rendre le script executable :

  ```shell
  chmod +x installateur.sh
  ```

- Executer la script :

  ```shell
  ./installateur.sh
  ```

- Vous pouvez maintenant choisir le thème nommer '`GitHub Dark Perso`' dans les paramètres de vscode

### Manuellement

- Assurez vous d'avoir installé l'extension Github thème qui à comme ID :
  > GitHub.github-vscode-theme
- Cloner le repertoire Github :

  ```shell
  git clone https://github.com/FloRobart/Themes_for_vsCode.git
  ```

- Copier le thème dans le répertoire des thèmes de vscode :

  ```shell
  cp "path/to/Themes_for_vsCode/Themes/dark-perso.json" "/home/$USER/.vscode/extensions/github.github-vscode-theme-<version>/themes/dark-perso.json"
  ```

- Modifier le fichier `package.json` pour y ajouter le nouveau thème

    Ajouter le texte suivant comme dans l'exemple si dessous

  ```json
  ,
  {
      "label": "GitHub Dark Perso",
      "uiTheme": "vs-dark",
      "path": "./themes/dark-perso.json"
  }
  ```

- Exemple

  ```json
  {
      ...
  
      "contributes": {
          "themes": [
  
              ...
  
              {
                  "label": "GitHub Dark",
                  "uiTheme": "vs-dark",
                  "path": "./themes/dark.json"
              },
              {
                  "label": "GitHub Dark Perso",
                  "uiTheme": "vs-dark",
                  "path": "./themes/dark-perso.json"
              }
          ]
      },
  
      ...
  }
  ```

- Vous pouvez maintenant choisir le thème nommer '`GitHub Dark Perso`' dans les paramètres de vscode

## Configuration de VS Code et des ses extensions

### Header et footer de l'extension `Markdown PDF` de vs code

- Header

  ```html
  <div style="font-size: 9px; margin-left: 1cm;"><span class='title'></span> - Floris Robart</div>  <div style="font-size: 9px; margin-left: auto; margin-right: 1cm; ">%%ISO-DATE%%</div>
  ```

- Footer

  ```html
  <div style="font-size: 9px; margin-left: auto; margin-right: auto; margin-bottom: -8px;"> <span style="font-size: 9px" class='pageNumber'></span> / <span class='totalPages'></span></div>
  ```

****

<a href="https://florobart.github.io/Documentations/"><button type="button">Retour à toute les documentations</button></a>
