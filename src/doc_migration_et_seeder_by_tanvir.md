# Migrations et Seeders

## Comment utiliser les migrations et seeders dans Lalachante

Lalachante contient des migrations et des seeders qui permettent de configurer les bases de donnees de l'application. Voici comment les utiliser:

### Les migrations

Les migrations sont des fichiers qui permettent de creer, modifier ou supprimer des tables dans une base de donnees. Les migrations sont executees en premier lieu pour configurer la base de donnees de l'application.

Pour utiliser les migrations, il suffit de lancer la commande `php artisan migrate:fresh --path=/database/<nom_du_fichier_de_migration> --database=<nom_de_la_bdd>`. Les migrations seront executees et la base de donnees sera configuree.

Voici les migrations disponibles dans Lalachante:

*   Migration 1: `mysql`

    *   Base de donnees: `team_fb_test`
    *   Commande: `php artisan migrate:fresh --path=/database/migrations --database=mysql`
*   Migration 2: `mysql2`

    *   Base de donnees: `customer_app`
    *   Commande: `php artisan migrate:fresh --path=/database/migration_2 --database=mysql2`
*   Migration 3: `mysql3`

    *   Base de donnees: `notification_app`
    *   Commande: `php artisan migrate:fresh --path=/database/migration_3 --database=mysql3`

### Les seeders

Les seeders sont des fichiers qui permettent de remplir les tables de la base de donnees avec des donnees. Les seeders sont executees apres les migrations pour fournir des donnees a l'application.

Pour utiliser les seeders, il suffit de lancer la commande `php artisan db:seed`. Les seeders seront executees et les tables seront remplies avec des donnees.

Si vous souhaitez ajouter des donnees manuellement, vous pouvez utiliser les fichiers sql dans le dossier `database/sql/`.



## Creation d'une migration et d'un seeder

### Pour creer une migration

La commande suivante cree un nouveau fichier de migration dans le dossier `/database/<nom_du_fichier_de_migration>`. Ce fichier contient deja les methodes `up` et `down` qui permettent de creer et de supprimer la table:

```bash
php artisan make:migration <nom_de_la_migration> --path=/database/<nom_du_fichier_de_migration>
```

***Convention de nommage :**  Lorsque l'on nomme un fichier de migration dans le terminal bash, il est recommandé de le créer de la forme suivante `create_<nom_de_la_table>_table`. Veuillez continuer à suivre cette méthode de dénomination.*

Ouvrez le fichier de migration situé dans le dossier `/database/<nom_du_fichier_de_migration>/<nom_de_la_migration>.php` et ajoutez le code qui permet de créer le tableau. L'aspect du fichier de migration est déjà configuré, il contient déjà les méthodes `up` et `down` qui permettent de créer et de supprimer la table. Utilisez ce template pour compléter le code en remplaçant les `<>` par les valeurs appropriées :

```PHP
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class <nom_de_la_migration> extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create(<nom_de_la_table>, function (Blueprint $table) {
            $table->increments(<nom_du_primaire>);
            $table->integer(<nom_de_la_colonne>)->nullable();
            $table->string(<nom_de_la_colonne>, <taille_de_la_colonne>)->nullable();
            ...
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists(<nom_de_la_table>);
    }
}
```

### Comment creer un seeder

Un seeder est un fichier qui permet de remplir les tables de la base de donnees avec des donnees. Les seeders sont executees apres les migrations pour fournir des donnees a l'application.

```bash
php artisan make:seeder <nom_de_la_seeder>
```

***Convention de nommage :**  Lorsque l'on nomme un fichier seeder dans le terminal bash, il est recommandé de le créer de la forme suivante `<NomDeTable>Seeder`. S'il y a un `s` avant `Seeder`, il est conseillé de supprimer ce `s`. Veuillez continuer à suivre cette méthode de dénomination.*

Ouvrez le fichier de seeder situé dans le dossier `/database/seeders/<nom_de_la_seeder>.php` et ajoutez le code nécessaire pour remplir le tableau avec des données. Le fichier de seeder contient deja la classe `<nom_de_la_seeder>` qui contient la méthode `run` qui permet de lancer le remplissage du tableau. Utilisez ce template pour compléter le code en remplaçant les `<>` par les valeurs appropriées :

```PHP
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class <nom_de_la_seeder> extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::connection(<nom_de_la_bdd>)->table(<nom_de_la_table>)->insert([
            [
                <nom_du_primaire> => <valeur_du_primaire>,
                <nom_de_la_colonne> => <valeur_de_la_colonne>,
                ...
            ]
        ]);
    }
}
```

Maintenant que vous avez cree le seeder, il est necessaire de l'ajouter dans `DatabaseSeeder` qui se trouve dans `/database/seeders/DatabaseSeeder.php`. Ajoutez le nom de la classe du seeder dans la methode `run` comme suit :

```PHP
<?php

namespace Database\Seeders;

use App\Models\ContactEntreprise;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        
        $this->call([
            <nom_de_la_seeder>::class,
        ]);
    }
}

```

## Conclusion

En suivant ce tutoriel, vous avez appris comment utiliser les migrations et les seeders pour gerer vos donnees. Vous avez appris comment creer un fichier de migration et un fichier de seeder en utilisant les commandes Artisan, comment les lancer, comment les utiliser pour remplir vos tables de donnees et comment les utiliser en fonction de vos besoins. Enfin, vous avez appris comment utiliser les seeders pour remplir les tables de votre base de donnees.
