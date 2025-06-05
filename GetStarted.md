# OJS Installation 
## Prerequisite 
### on Linux 
- Node.js and npm needs to be installed 
    - `sudo apt-get install nodejs ` 
    - `sudo apt-get install npm`
- PHP needs to be installed  
    - `sudo apt-get install php` 
    - required extensions for ojs 
        - `sudo apt install php-cli php-json php-mbstring php-xml php-pcov php-xdebug` 
- Composer needs to be installed 
    - `sudo apt-get install composer`
- Apache needs to be installed 
    - `sudo apt-get install apache2` 
- MYSQL needs to be installed  
    - Installation 
        - `sudo apt-get install mysql-server` 
        - `sudo apt-get install php-mysql` 
        - check if mysql is running `systemctl status mysql` 
            - leave `Strg + C`
    - GetStarted MySQL for ojs 
        - check if mysql is running `systemctl status mysql`
        - stop mysql `sudo systemctl stop mysql` 
        - start mysql `sudo systemctl start mysql`
        - mit root mysql öffnen `sudo mysql -u root`
            - leave `Strg + Z`    
        - Show databases `SHOW DATABASES;`
        - Create database `CREATE DATABASE ojs;`
            - Delete database `DROP DATABASE ojs;`
        - Show users 
            - all details `SELECT * FROM mysql.user;`
            - less info `SELECT user,host FROM mysql.user;`
        - Create user   
            - create `CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs';`
            - grant access `GRANT ALL PRIVILEGES ON ojs.* TO 'ojs'@'localhost';`
            - apply privileges `FLUSH PRIVILEGES;`
            - delete user `DROP USER 'ojs'@'localhost';`

### on macOS 
- [Homebrew](https://brew.sh/) needs to be installed 
    - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
    - `echo >> /Users/username/.zprofile`
    - `echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/username/.zprofile`
    - `eval "$(/opt/homebrew/bin/brew shellenv)"`
- Node.js and npm needs to be installed 
    -  `brew install node`
- Follow the [GRAV Guide](https://getgrav.org/blog/macos-sequoia-apache-multiple-php-versions) to install the following packages. We recommend to fufill all steps (except the installation of _Grav CMS_) in this guide.  
    - _XCode Command Line Tools_
    - _openssl_
    - _Apache_
    - _VSC_ 
    - _PHP_ 
        -  Install the different PHP versions as different OJS versions require different PHP versions. 
- Composer needs to be installed 
    - `brew install composer`
- MYSQL needs to be installed 
    - Installation
        - `brew install mysql` 
    - GetStarted MySQL for ojs
        - Handling  
            - start `brew services start mysql` 
            - stop `brew services stop mysql`
            - restart `brew services restart mysql`
            - open as root `sudo mysql -u root` 
            - exit `exit`
        - Initialisation
            - Show databases `SHOW DATABASES;`
            - Create database `CREATE DATABASE ojs;`
                - Delete database `DROP DATABASE ojs;`
            - Show users 
                - all details `SELECT * FROM mysql.user;`
                - less info `SELECT user,host FROM mysql.user;`
            - Create user   
                - create `CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs';`
                - grant access `GRANT ALL PRIVILEGES ON ojs.* TO 'ojs'@'localhost';`
                - apply privileges `FLUSH PRIVILEGES;`
                - delete user `DROP USER 'ojs'@'localhost';`

## OJS
- There are two options to install OJS, either you install the latest version via GitHub or a recent Release.
    - GitHub
        - Follow instructions: https://docs.pkp.sfu.ca/dev/documentation/en/getting-started
    - Release 
        - Download the desired version via: https://pkp.sfu.ca/software/ojs/download/ 
- Note that different versions of OJS require different versions of PHP, e.g. we recommend PHP 7.4 for OJS 3.3.
- Start
    - `cd /ojs`
    - `php -S localhost:8000` 
- Follow instructions: http://localhost:8000/index.php/index/install 
    - Create folder for ojs files 
        - `mkdir ojs-files` 
    - Add writing permissions 
        - See permissions `ls -l`
        - Add read, writing, execute permissions `chmod +rwx fileDirectory` 
            - In directory ojs 
                - `chmod ugo+rwx config.inc.php`
                - `chmod ugo+rwx public/`
                - `chmod ugo+rwx cache/`
                - `chmod ugo+rwx cache/t_cache/`
                - `chmod ugo+rwx cache/t_compile/`
                - `chmod ugo+rwx cache/_db`
                - `chmod ugo+rwx ojs-files/` (the folder you have just created for your ojs files)
    - Create OJS account
        - Username & Password: ojs 
        - Enter an email   

### Start & Stop OJS  
- Start
    - `cd /ojs`
    - `php -S localhost:8000`
- Stop 
    - `CTRL` + `C`

### geoMetadata Plugin Installation 
- Create a journal in OJS.  
- Follow [Download & Installation](https://github.com/TIBHannover/geoMetadata?tab=readme-ov-file#download--installation) instructions.  


## Debugging  
_ToDo_

## Database Viewer 
_ToDo_