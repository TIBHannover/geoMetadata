{**
 * templates/submission/formsubmissionMetadataFormFields.tpl
 *
 * Copyright (c) 2024 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Add forms to enter geospatial metadata during the submission.
 * 
 * The main template is here extended using the hook 'Templates::Submission::SubmissionMetadataForm::AdditionalMetadata'.
 *}

<link rel="stylesheet" href="{$pluginStylesheetURL}/styles.css" type="text/css" />

<input type="text" id="geoMetadata_usernameGeonames" name="usernameGeonames" class="hiddenDataField" value="{$usernameGeonames}" />
<input type="text" id="geoMetadata_baseurlGeonames" name="baseurlGeonames" class="hiddenDataField" value="{$baseurlGeonames}" />
<input type="text" id="geoMetadata_coverageDisabledHover" name="coverageDisabledHover"
        style="height: 0px; width: 0px; visibility: hidden;"
        value="{translate key="plugins.generic.geoMetadata.submission.coverageDisabledHover"}">
        
<div style="clear:both;">
    {fbvFormArea id="spatioTemporalFields"}

    {*temporal*}
    {fbvFormSection title="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal" for="timePeriodsWithDatepicker" inline=true}
    <p align="justify" class="description">{translate
        key="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal.description.submission"}
    </p>
    <input type="text" id="timePeriodsWithDatepicker" name="datetimes" style="width: 100%; height: 32px; z-index: 0;" />
    <textarea id="timePeriods" name="{$smarty.const.GEOMETADATA_DB_FIELD_TIME_PERIODS}"
        class="hiddenDataField" style="height: 0;">{${$smarty.const.GEOMETADATA_DB_FIELD_TIME_PERIODS}}</textarea>
    {/fbvFormSection}

    {*spatial*}
    {fbvFormSection title="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial" for="spatialProperties" inline=true}
    <p align="justify" class="description">{translate
        key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.description.submission"}
    </p>
    <div id="mapdiv" style="width: 100%; height: 400px; z-index: 0;"></div>
    <textarea id="spatialProperties" name="{$smarty.const.GEOMETADATA_DB_FIELD_SPATIAL}"
        class="hiddenDataField" style="height: 0;">{${$smarty.const.GEOMETADATA_DB_FIELD_SPATIAL}}</textarea>

    <p align="justify" class="description">{translate
        key="plugins.generic.geoMetadata.license.submission"} {$geoMetadata_metadataLicense}
    </p>
    {/fbvFormSection}

    {*administrativeUnit*}
    {fbvFormSection title="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.administrativeUnit" for="administrativeUnitInput"
    inline=true}
    <p align="justify" class="description geoMetadata_warning" id="geoMetadata_gazetteer_unavailable" style="display:none;">{translate
        key="plugins.generic.geoMetadata.geospatialmetadata.gazetteer_unavailable"}
    </p>
    <p align="justify" class="description">{translate
        key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.administrativeUnit.description.submission"}
    </p>
    <ul id="administrativeUnitInput">
    </ul>
    <textarea id="administrativeUnit" name="{$smarty.const.GEOMETADATA_DB_FIELD_ADMINUNIT}"
        class="hiddenDataField" style="height: 0;">{${$smarty.const.GEOMETADATA_DB_FIELD_ADMINUNIT}}</textarea>
    {/fbvFormSection}
    {/fbvFormArea}
</div>

{*z-index must be changed for the daterangepicker*}
<style>
    .daterangepicker {
        direction: ltr;
        text-align: left;
        z-index: 1;
    }
</style>

{*main js script, needs to be loaded last*}
<script src="{$geoMetadata_submissionJS}" type="text/javascript"></script>
