# Documentation de Gnome Shell Connect (GSConnect)

## Table des matières

- [Documentation de Gnome Shell Connect (GSConnect)](#documentation-de-gnome-shell-connect-gsconnect)
    - [Table des matières](#table-des-matières)
    - [Description de GSConnect](#description-de-gsconnect)
    - [Installation de GSConnect](#installation-de-gsconnect)
    - [Licence](#licence)

## Description de GSConnect

GSConnect est une extension pour Gnome Shell qui permet de connecter un smartphone Android à un ordinateur sous Gnome. Elle permet de synchroniser les notifications, les messages, les appels, les fichiers, la copie de texte, le partage de liens, le partage de fichiers, le contrôle multimédia, le contrôle de la souris et du clavier, le partage de la connexion internet, de faire sonner le téléphone et bien plus encore.

GSConnect est un outils incroyable de permet de faire énormément de choses entre un smartphone Android et un ordinateur sous Gnome.

## Installation de GSConnect

- Source
    > <https://askubuntu.com/questions/1036351/how-to-install-and-run-gsconnect-to-have-android-integration-transfer-files-se>

- Installer le paquet `gnome-shell-extensions` du dépot `apt`, qui permet de voir les extensions installées :

    ```shell
    sudo apt install gnome-shell-extensions
    ```

- Installer l'extension `chrome-gnome-shell` du dépot `apt`, qui permet de gérer les extensions Gnome Shell depuis le navigateur :

    ```shell
    sudo apt install chrome-gnome-shell
    ```

- Installer l'extension chrome (ou firefox) GSConnect disponible sur le [Chrome Web Store](https://chromewebstore.google.com/detail/gsconnect/jfnifeihccihocjbfcfhicmmgpjicaec?hl=fr&utm_source=ext_sidebar)
- Aller sur la page de l'extention `GSConnect` sur le site de Gnome à l'adresse suivante :
    > <https://extensions.gnome.org/extension/1319/gsconnect/>
- Cliquer sur le bouton `Installer` pour installer l'extension
- Installer l'application `KDE Connect` sur le smartphone Android depuis le [Google Play Store](https://play.google.com/store/search?q=kde+connect&c=apps&hl=fr)
- Assurez-vous que le smartphone et l'ordinateur sont connectés au même réseau
- Assurez-vous que l'extension est activée dans les paramètres de Gnome Shell

    ![Image kde_connect_activation](../images/kde_connect_activation.png)

- Ouvrir l'application `KDE Connect` sur le smartphone
- Cliquer sur le nom de l'ordinateur dans la liste des appareils disponibles
    - Si l'ordinateur n'apparait pas, cliquer sur le bouton `+` en haut à droite de l'application et entrer l'adresse IP de l'ordinateur

- Noter qu'après la première connexion, l'ordinateur et le smartphone se connecteront automatiquement lorsqu'ils seront sur le même réseau

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
