{**
 * templates/submission/form/publicationTab.tpl
 *
 * Copyright (c) 2022 OPTIMETA project
 * Copyright (c) 2022 Daniel Nüst
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Show geospatial metadata and allow editing during publication phase.
 *}

<link rel="stylesheet" href="{$pluginStylesheetURL}/geoMetadata.css" type="text/css" />

{* see templates/workflow/workflow.tpl for HTML structure, CSS classes, etc., used below *}

{* configuration values that are need in JS *}
<input type="text" id="geoMetadata_usernameGeonames" name="usernameGeonames" class="hiddenDataField" value="{$usernameGeonames}" />
<input type="text" id="geoMetadata_baseurlGeonames" name="baseurlGeonames" class="hiddenDataField" value="{$baseurlGeonames}" />
<input type="text" id="geoMetadata_coverageDisabledHover" name="coverageDisabledHover"
        style="height: 0px; width: 0px; visibility: hidden;"
        value="{translate key="plugins.generic.geoMetadata.submission.coverageDisabledHover"}">
    
<tab id="timeLocation" label="{translate key="plugins.generic.geoMetadata.publication.label"}">

    {*temporal*}
    <div class="pkpFormGroup__locale pkpFormGroup__locale--isVisible geoMetadata_formGroupMargin">
        <div class="pkpFormField">
            <div class="pkpFormField__heading">
                <label for="geoMetadata-temporal" class="pkpFormFieldLabel">
                    {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal"}
                </label>
            </div>
            <div id="geoMetadata-temporal-description" class="pkpFormField__description">
                {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal.description.submission"}
            </div>
            <div class="pkpFormField__control">
                <div class="pkpFormField__control_top">
                    <input id="geoMetadata-temporal" name="datetimes" aria-describedby="geoMetadata-temporal-description" aria-invalid="0" type="text" class="pkpFormField__input pkpFormField--text__input" />
                </div>
            </div>
        </div>
    </div>

    {*spatial*}
    <div class="pkpFormGroup__locale pkpFormGroup__locale--isVisible geoMetadata_formGroupMargin">
        <div class="pkpFormField">
            <div class="pkpFormField__heading">
                <label for="mapdiv" class="pkpFormFieldLabel">
                    {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial"}
                </label>
            </div>
            <div id="geoMetadata-spatial-description" class="pkpFormField__description">
                {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.description.submission"}
            </div>
            
            <div id="mapdiv" aria-describedby="geoMetadata-spatial-description" style="width: 100%; height: 400px; z-index: 0;"></div>
        </div>
    </div>

    {*administrativeUnit*}
    <div class="pkpFormGroup__locale pkpFormGroup__locale--isVisible geoMetadata_formGroupMargin">
        <div class="pkpFormField">
            <div class="pkpFormField__heading">
                <label for="administrativeUnitInput" class="pkpFormFieldLabel">
                    {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.administrativeUnit"}
                </label>
            </div>
            <div align="justify" class="pkpFormField__description geoMetadata_warning" id="geoMetadata_gazetteer_unavailable" style="display:none;">{translate
                key="plugins.generic.geoMetadata.geospatialmetadata.gazetteer_unavailable"}
            </div>
            <div id="geoMetadata-adminunit-description" class="pkpFormField__description">
                {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.administrativeUnit.description.submission"}
            </div>
            <div class="pkpFormField__control">
                <div class="pkpFormField__control_top">
                    <ul id="administrativeUnitInput" aria-describedby="geoMetadata-adminunit-description" aria-invalid="0" class="pkpFormField__input pkpFormField--text__input">
                    </ul>
                </div>
            </div>
        </div>
    </div>

    {*z-index must be changed for the daterangepicker*}
    <style>
        .daterangepicker {
            direction: ltr;
            text-align: left;
            z-index: 1;
        }
    </style>

    <div class="pkpFormField__heading geoMetadata_formGroupMargin">
        <label class="pkpFormFieldLabel">
            {translate key="plugins.generic.geoMetadata.publication.tab.raw"}
        </label>
    </div>
    <div class="pkpFormField__description">
        {translate key="plugins.generic.geoMetadata.publication.tab.raw.description"}
    </div>

    <div>
        <pkp-form v-bind="components.{$smarty.const.GEOMETADATA_FORM_NAME}" @set="set"/>
    </div>

    {*main js script, needs to be loaded last*}
    <script src="{$geoMetadata_submissionJS}" type="text/javascript"></script>
    
    {* fix Leaflet gray map issue when it is displayed later than page load *}
    <script type="text/javascript">
        // https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver
        // https://stackoverflow.com/a/16462443
        $(function() {
            var observer = new MutationObserver(function(mutations) {
                if(mutations[0].attributeName === "hidden" && mutations[0].target.attributes['hidden'] === undefined)
                setTimeout(function () {
                    //window.dispatchEvent(new Event('resize'));
                    map.invalidateSize();
                }, 100);
            });
            var target = document.querySelector('#timeLocation');
            observer.observe(target, {
                attributes: true
            });
        });
    </script>

</tab>
