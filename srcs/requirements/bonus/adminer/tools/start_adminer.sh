#!bin/bash


wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php 
chown -R www-data:www-data /var/www/html/adminer.php 
chmod 755 /var/www/html/adminer.php


cd /var/www/html

rm -rf index.html
php -S 0.0.0.0:80


#| Ligne               | Fonction                                                                |
#| `chown ...`         | Donne les droits à l'utilisateur `www-data`, utilisé par PHP.           |
#| `chmod ...`         | Autorise le fichier à être lu et exécuté.                               |
#| `cd /var/www/html`  | Va dans le dossier où le site est hébergé.                              |
#| `rm -f index.html`  | Supprime un éventuel `index.html` qui pourrait gêner.                   |
#| `php -S 0.0.0.0:80` | Lance un serveur PHP local écoutant sur le port 80.                     |
