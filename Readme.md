Awesome configuration
===============

- - -

Ce repos contient tous les elements necessaire pour awesome (trois ecrans).

Version Dark par Aurélien Frances (Stratos)

- - -

Installation
------------

Pour utiliser cette configuration d'awesome, vous devez installer les paquets :

 - Awesome-wm
 - dmenu
 - feh (pour les fonds d'ecran)
 - urxvt

Ensuite, creez le dossier ~/.config/ s'il n'existe pas.

Une fois cree, vous avez le choix entre :

    - cloner directement le depot git dans le dossier
      ~/.config avec la commande suivante :

      # cd ~/.config &&
        git clone http://[<login>@]git.aufrinfo.net/git/awesome-three-screen.git awesome

      en replacant login par votre identifiant si necessaire.
      (Anonyme autorise pour le clone)

    - renommer le depot deja clone en ~/.config/awesome

Lancez ou relancez awesome (par defaut 'Ctrl-Shift R')

Configuration
-------------

### Theme

Par defaut, la configuration est delivre avec le theme dark. Le fichier theme.lua situe
dans ~/.config/awesome/themes/dark/ definit les couleur de l'environnement de travail.

Les variables couleurs sont definies dans le fichier color.lua en hexadecimal.

Les themes par defaut d'awesome restent a disposition dans /usr/share/awesome/themes/
pour changer de theme, modifier la ligne 27 du fichier rc.lua tel que:

     beautiful.init("/home/" .. USER .. "/.config/awesome/themes/dark/theme.lua")

devienne:

     beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

en remplacant zenburn par le theme choisi.

- - -

### Widgets

Les widgets active par defaut proviennent de la lib vicious (fourni dans le depot)
http://git.sysphere.org/vicious/

D'autres widgets sont disponibles dans le repertoire ~/.config/awesome/vicious/

- - -

Pour tout bugs, remarques, etc. Vous pouvez me contacter a
stratos@aufrinfo.net
