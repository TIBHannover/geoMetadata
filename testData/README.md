# geoMetadata Test Dataset 
## Apply the geoMetadata Test Dataset to an OJS instance 
- Fulfill the prequisites as described in [GetStarted.md](../GetStarted.md#prerequisite) 
- Download a [version of OJS](https://pkp.sfu.ca/software/ojs/download/) 
- Clone the [PKP Datasets Repository](https://github.com/pkp/datasets) 
    - Place it somewhere on your local machine — there is no need for it to be in the direcrtory of the beforehand installed OJS instance
- Copy the directory [stable-3_3_0-geoMetadata](stable-3_3_0-geoMetadata) into the directory `/datasets/ojs` of the PKP Datasets Repository
    - _If there is no `mysql` directory available, you can probably copy the content of the `mariadb` directory into a new `mysql` directory, and the data dump should still function._
- `cd /ojs` in the directory of the installed OJS instance 
    - `mkdir files`
    - `export DBTYPE=MariaDB DBTYPE_SYMBOLIC=mariadb DBUSERNAME=ojs_dump DBPASSWORD=ojs_dump DBNAME=ojs_dump DBHOST=localhost APP=ojs BRANCH=stable-3_3_0-geoMetadata`
        - Adapt the variables depending on your database configuration
        - `BRANCH=stable-3_3_0-geoMetadata` required to load the geoMetadata test dataset 
    - `/datasets/tools/load.sh` 
        - Adapt the path according to the directory in which the PKP datasets repository is located. 
- Adapt the database settings in the `config.inc.php` depending on your database configuration 
    ```
    driver = mysqli
    host = localhost
    username = ojs_dump
    password = ojs_dump
    name = ojs_dump
    ```
- `cd /ojs` 
    - `php -S localhost:8000`

## Create Test Dataset 
- Create directory `/stable-3_3_0-geoMetadata`
- Export a dump from your current used OJS database and create a `database.sql`  
    - `mysqldump -u root ojs_dump > /stable-3_3_0-geoMetadata/database.sql` 
- Prepare the OJS instance for demonstration purposes
    - Include demo content 
    - Delete all credentials (e.g. plugin settings)
    - Only the admin should be able to create new accounts (`User & Roles` -> `Site Access Options` -> `User Registration` -> `The Journal Manager will register all user accounts. Editors or Section Editors may register user accounts for reviewers.`)
    - einstellen dass nur admin nutzer erstellen kann 
- Copy the content of your ojs files directory into `/stable-3_3_0-geoMetadata/folder`. This directory shall include directories like `journals`, `scheduledTaskLogs`, `usageStats`. 
- Copy the content of your `ojs/public` folder into `/stable-3_3_0-geoMetadata/public`
- Copy the `ojs/config.inc.php` into `/stable-3_3_0-geoMetadata/config.inc.php` 
- Delete any not required content, especially logs (have a look at [stable-3_3_0-geoMetadata](stable-3_3_0-geoMetadata) to see which files and directories are required). 
