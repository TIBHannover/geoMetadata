[![OPTIMETA Logo](https://projects.tib.eu/fileadmin/_processed_/e/8/csm_Optimeta_Logo_web_98c26141b1.png)](https://projects.tib.eu/optimeta/en/) [![KOMET Logo](https://projects.tib.eu/fileadmin/templates/komet/tib_projects_komet_1150.png)](https://projects.tib.eu/komet/en/)

# geoMetadata Plugin
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8198983.svg)](https://doi.org/10.5281/zenodo.8198983)

The geoMetadata Plugin (formerly known as OJS Geo Plugin or OPTIMETA Geo Plugin) offers a novel way to capture and provide geospatial properties of research articles in [Open Journal Systems (OJS)](https://pkp.sfu.ca/ojs/).
It is developed as part of the BMBF-funded projects [OPTIMETA](https://projects.tib.eu/optimeta/en/) and [KOMET](https://projects.tib.eu/komet/en/).

The KOMET team develops further plugins like the [citationManager](https://github.com/TIBHannover/citationManager) and [pidManager](https://github.com/TIBHannover/pidManager). 
Visit the [KOMET project website](https://projects.tib.eu/komet/output/) for a full overview of the project output.

## Functionality  
Authors can either search for a location and accept the suggested bounding box or manually create one or more suitable geometric shape(s) on a map.
If authors enter geometries, a gazetteer is used to suggest a matching administrative unit’s name to the author.
This allows the plugin to store geospatial data in two forms: as text, using an administrative unit or standardised geographical norm data, and as geospatial coordinates in GeoJSON format.
Thereby the coordinates are stored accurately, while at the same time a textual description is accessible and flexible for non-map-related usage.
Authors can also choose to specify the temporal range within which the research was conducted.
In the article view, the properties specified by the author are then displayed and available for download as geoJSON.
In addition, the information is also added to the HTML source code of article’s landing pages in a semantically meaningful way.

<div style="text-align:center">
<img src="screenshots/SubmissionView.png" alt="Alt-Text" title="Screenshot of entering geospatial properties in the OJS submission process" width="50%" align="middle"/>
<br/>
<em>Screenshot of entering geospatial properties in the OJS submission process</em>
</div>

<div style="text-align:center">
<img src="screenshots/ArticleView.png" alt="screenshot of geo plugin" title="Screenshot of geospatial properties in the OJS article view" width="50%" align="middle"/>
<br/>
<em>Screenshot of geospatial properties in the OJS article view</em>
</div>

## Publications 
- A first prototype of the geoMetadata Plugin was developed under the name *geoOJS* by Tom Niers for the BSc. thesis [Geospatial Metadata for Discovery in Scholarly Publishing](http://nbn-resolving.de/urn:nbn:de:hbz:6-69029469735); the work was [presented at The Munin Conference on Scholarly Publishing, 2020](https://doi.org/10.7557/5.5590), see [recording](https://youtu.be/-Lc9AjHq_AY).

## Download & Installation

This version of the plugin is compatible with OJS Version `3.3 LTS`, especially `OJS 3.3.0-19`. 
You can find the corresponding OJS version in the [PKP Software Download Section](https://pkp.sfu.ca/software/ojs/download/) and download it by using the following link: <https://pkp.sfu.ca/ojs/download/ojs-3.3.0-19.tar.gz>. 

Once OJS has been installed, the plugin must be downloaded and installed.

### From Source
1. Checkout the desired version from [the code repository](https://github.com/TIBHannover/geoMetadata/) and save the contents into `ojs/plugins/generic/geoMetadata` in your OJS installation.
1. Run `composer install` to download JavaScript dependencies for the plugin using [Asset Packagist](https://asset-packagist.org/site/about).
   Go to `js/lib/leaflet-control-geocoder` and run `npm install` (see [this issue](https://github.com/perliedman/leaflet-control-geocoder/issues/310)).
1. Activate the plugin in the OJS plug-in settings.


### Via Release
*Currently not available*

~~See releases at <https://github.com/TIBHannover/geoMetadata/releases>. The release bundles contain plugin source code as well as the the required JavaScript dependencies so the plugin is ready to be used.~~

## Configuration

1. Configure **GeoNames**

   You have to specify your username for the GeoNames API, so that an alignment for the administrative units is possible.

   1. Create an account on <https://www.geonames.org/login> and enable it by clicking the activiation link you get via email.
   1. Go to <https://www.geonames.org/manageaccount> and enable your account for free web services. 
   1. Enter the username and the GeoNames BaseURL in the settings (OJS > Dashboard > Website > Plugins > Installed Plugins > geoMetadata > blue arrow > Settings).

1. Configure **Issue TOC** 

   The plugin displays geospatial information for each article included in an issue on a map on the issue page. 
   To enable this feature, you need to change a line of code in the main OJS code. 

   - You need to add the following line of code to the [issue_toc.tpl](https://github.com/pkp/ojs/blob/bad437e0ef240afb2370c0548e55fb18716fd278/templates/frontend/objects/issue_toc.tpl) in [line 130](https://github.com/pkp/ojs/blob/bad437e0ef240afb2370c0548e55fb18716fd278/templates/frontend/objects/issue_toc.tpl#L130): 

      `{call_hook name="Templates::Issue::TOC::Main"}` 
      
   - After your changes the file should look at this section like this:  

      _line 129_ `{/foreach}`

      _line 130_ `{call_hook name="Templates::Issue::TOC::Main"}`

      _line 131_ `</div><!-- .sections -->`
   
1. Configure **Journal Map**

   The plugin displays geospatial information for each article included in a journal on a map. This map is available via `journalURL/map` e.g. `https://examplePublisher/index.php/exampleJournal/map`. 
   
   This map is available via the URL, but you could also provide the option for users of your journal to access the map by clicking on a button in the _Primary Navigation Menu_. To do this, you need to carry out the following steps. 

   1. Enter the corresponding menu (OJS > Dashboard > Website > Setup > Navigation).
   1. Add the Navigation Menu Item _Map_.

      1. _Add Item_ 
      1. Title: _Map_ 
      1. Navigation Menu Type: _Remote URL_  
      1. URL: _journalURL/map_  

   1. Add Navigation Menu Item _Map_ to _Primary Navigation Menu_. 

      0. If the _Primary Navigation Menu_ is not available you have to create it. 

         1. _Add Menu_ 
         1. Title: _Primary Navigation Menu_ 
         1. Active Theme Navigation Areas: _primary_
         1. Continue with step 3 of the following list and add any additional items you want to make available to the user. 

      1. _Blue Arrow_ next to _Primary Navigation Menu_ 
      1. _Edit_ 
      1. Place the Menu Item _Map_ at the place where the user should find it. You can move the item _Map_ from the _Unassigned Menu Items_ to the _Assigned Menu Items_. 

Further information on the geoJSON specification is available via a [wiki](https://github.com/tomniers/geoOJS/wiki/geoJSON-Specification). 

## Contribute
All help is welcome: asking questions, providing documentation, testing, or even development.

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.

## Notes about accuracy
The spatial metadata is saved in GeoJSON format using the EPSG:4326 coordinate reference system (CRS) and the underlying dynamic WGS84 datum.
This means that even the same coordinates can point to different locations on Earth over time, as the so called "epoch" is not saved.
However, this only leads to an uncertainty of about +/- 2 m, which is generally _no problem at all_ for the use case of global dataset discovery.

## Testing
Tests are run with [Cypress](https://www.cypress.io/), for which dependencies are installed with npm using the `package.json`.

### Running Cypress locally

```bash
# see also Cypress' system dependencies at https://docs.cypress.io/guides/getting-started/installing-cypress#Advanced-Installation
npm install

npx cypress open

# start compose configuration for desired OJS version, running on port 8080; OJS_VERSION is a image tag for pkpofficial/ojs
export OJS_VERSION=3_3_0-11 && docker-compose --file cypress/docker-compose-mysql.yml down --volume && docker-compose --file cypress/docker-compose-mysql.yml up
export OJS_VERSION=3_2_1-4 && docker-compose --file cypress/docker-compose-mysql.yml down --volume && docker-compose --file cypress/docker-compose-mysql.yml up

# open/run Cypress tests with a given OJS version
npm run cy_open
npm run cy_run
```

To debug, add `debugger;` to the code and make sure to have the developer tools open in the browser windows started by Cypress.

### Writing tests

1. Start docker-compose configuration (see above)
1. Start Cypress (see above)
1. Write tests, run them in Cypress
1. If you need a clean start (= empty database) for a test, stop the docker-compose configuration, delete it (`down --volume`) and restart it

## Create a release

1. Run `composer update` and `composer install`
1. Update the release version in `version.xml`
1. Add a git tag and push it to GitHub
1. Create a zip archive of the local files with the following command to include the required dependencies from `vendor/` and `js/lib/` but to exclude non-essential files:

   ```bash
   rm geoMetadata.zip && zip -r geoMetadata.zip ./ --exclude '*.git*' --exclude '*.github/*' --exclude 'node_modules/*' --exclude '*cypress/*' --exclude '*.gitignore*' --exclude '*.npmignore*' --exclude '*messages.mo*' --exclude '*cypress.config.js*' --exclude '*CONDUCT.md*' --exclude '*screenshots/*'
   ```

1. Create a new release on GitHub using the tag just created, with a fitting title, description and, if need be, the `pre-release` box checked
1. Upload the archive to the release on GitHub

Later release workflows will include usage of the PKP CLI tool, see <https://docs.pkp.sfu.ca/dev/plugin-guide/en/release>.

## License

This project is published under GNU General Public License, Version 3.
