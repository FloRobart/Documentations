# Documentation de Visual Studio Code

## Table des matières

- [Documentation de Visual Studio Code](#documentation-de-visual-studio-code)
    - [Table des matières](#table-des-matières)
    - [Installation de Visual Studio code - Linux](#installation-de-visual-studio-code---linux)
        - [Avec un fichier deb (recommandé)](#avec-un-fichier-deb-recommandé)
        - [Avec le dépot snap](#avec-le-dépot-snap)
    - [Installation de mon thème personnalisé pour vscode - Linux](#installation-de-mon-thème-personnalisé-pour-vscode---linux)
        - [Avec le script d'installation](#avec-le-script-dinstallation)
        - [Manuellement](#manuellement)
    - [Configuration de VS Code et des ses extensions](#configuration-de-vs-code-et-des-ses-extensions)
        - [Header et footer de l'extension `Markdown PDF` de vs code](#header-et-footer-de-lextension-markdown-pdf-de-vs-code)
        - [Réparer l'erreur de JDK introuvable sur Visual Studio Code (vs code) - Linux](#réparer-lerreur-de-jdk-introuvable-sur-visual-studio-code-vs-code---linux)
    - [Licence](#licence)

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

### Réparer l'erreur de JDK introuvable sur Visual Studio Code (vs code) - Linux

- Éditer le fichier `.bashrc` :

    ```shell
    code /home/${USER}/.bashrc
    ```

- Ajouter les lignes suivantes à la fin du fichier `.bashrc` :
    - Dans mon cas le chemin vers le JDK est `/usr/lib/jvm/java-17-openjdk-amd64`

    ```shell
    # Ajout de la variable JAVA_HOME pour vs code
    export JAVA_HOME='<path to jdk>'
    export PATH="${PATH}:${JAVA_HOME}/bin"
    ```

- Mettre à jour le fichier `.bashrc` :

    ```shell
    source /home/${USER}/.bashrc
    ```

- Fermer puis réouvrir vs code
- Aller dans les paramètres de vs code
- Rechercher "`java runtime`"
- Vous devrier voir '`Java › Configuration: Runtimes`'
- Cliquer sur '`Modifier dans setting.json`'

    !["Image des paramètres de vs code"](../images/java_config_jdk.png "Image des paramètres de vs code")

- Ajouter la valeur de java home dans le fichier `settings.json` comme montrer ci-dessous :

    ```json
        ...
        "git.autofetch": true,
        "git.confirmSync": false,
        "workbench.colorTheme": "GitHub Dark Perso",
        "java.jdt.ls.java.home": "<add JAVA_HOME here>",
        "explorer.confirmDelete": false,
            "java.configuration.runtimes": [
                {
                    "name": "JavaSE-17",
                    "path": "<add JAVA_HOME here>",
                    "default": true
                }
            ],
            "diffEditor.ignoreTrimWhitespace": false,
            ...
    ```

    - Dans mon cas :

        ```json
            ...
            "git.autofetch": true,
            "git.confirmSync": false,
            "workbench.colorTheme": "GitHub Dark Perso",
            "java.jdt.ls.java.home": "/usr/lib/jvm/java-17-openjdk-amd64",
            "explorer.confirmDelete": false,
                "java.configuration.runtimes": [
                    {
                        "name": "JavaSE-17",
                        "path": "/usr/lib/jvm/java-17-openjdk-amd64",
                        "default": true
                    }
                ],
                "diffEditor.ignoreTrimWhitespace": false,
                ...
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
