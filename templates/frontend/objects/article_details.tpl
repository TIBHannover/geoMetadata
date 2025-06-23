{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2025 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Show geospatial metadata on the article page.
 *
 * the main template is here extended using the hook 'Templates::Article::Main'.
 *}

<script type="text/javascript">
const geoMetadata_mapLayerStyle = {
    weight: 5,
    color: '#1E6292',
    dashArray: '',
    fillOpacity: 0.6
};

const geoMetadata_articleLayerName = '{translate key="plugins.generic.geoMetadata.map.articleLayerName"}';
const geoMetadata_adminLayerName = '{translate key="plugins.generic.geoMetadata.map.administrativeLayerName"}';
</script>

<div style="clear:both;">
    <section id="geoMetadata_article_geospatialmetadata" class="item geospatialmetadata">
        <h2 class="label">{translate key="plugins.generic.geoMetadata.article.metadata.long"}</h2>

        {*temporal*}
        <p id="geoMetadata_article_temporal" class="description">
            {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal.from"} <span id="geoMetadata_span_start"  class="geoMetadata_timestamp"></span>
            {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal.to"}   <span id="geoMetadata_span_end" class="geoMetadata_timestamp"></span>.&nbsp;<span class="fa fa-question-circle tooltip">
                <span class="tooltiptext">{translate
                key="plugins.generic.geoMetadata.geospatialmetadata.properties.temporal.description.article"}</span>
            </span>
        </p>

        {*spatial*} {*administrativeUnit*}
        <p id="geoMetadata_article_spatial" class="description">
            {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial"}&nbsp;<span class="fa fa-question-circle tooltip">
                <span class="tooltiptext">{translate
                key="plugins.generic.geoMetadata.geospatialmetadata.properties.spatial.description.article"}</span>
        </p>

        <div id="mapdiv" style="width: 100%; height: 300px; z-index: 1;"></div>

        <p id="geoMetadata_article_administrativeUnit" class="description">
            {translate key="plugins.generic.geoMetadata.geospatialmetadata.properties.administrativeUnit"} <span id="geoMetadata_span_admnistrativeUnit" class="geoMetadata_coverage"></span>&nbsp;<span class="fa fa-question-circle tooltip">
            <span class="tooltiptext">{translate
                key="plugins.generic.geoMetadata.geospatialmetadata.properties.administrativeUnit.description.article"}</span>
            </span>
        </p>

        <p class="geoMetadata_license">
            {translate key="plugins.generic.geoMetadata.license.frontend"} {$geoMetadata_metadataLicense}
        </p>

        {* name is used for the submitted form and the name in the PHP backend, id is used for JavaScript *}
        <input type="text" id="geoMetadata_temporal" name="{$smarty.const.GEOMETADATA_DB_FIELD_TIME_PERIODS}"
            style="height: 0px; width: 0px; visibility: hidden;" value='{${$smarty.const.GEOMETADATA_DB_FIELD_TIME_PERIODS}}' />
        <input type="text" id="geoMetadata_spatial" name="{$smarty.const.GEOMETADATA_DB_FIELD_SPATIAL}"
            style="height: 0px; width: 0px; visibility: hidden;" value='{${$smarty.const.GEOMETADATA_DB_FIELD_SPATIAL}|escape:'html'}' />
        <input type="text" id="geoMetadata_administrativeUnit" name="{$smarty.const.GEOMETADATA_DB_FIELD_ADMINUNIT}"
            style="height: 0px; width: 0px; visibility: hidden;" value='{${$smarty.const.GEOMETADATA_DB_FIELD_ADMINUNIT}|escape:'html'}' />
    </section>

</div>

{*main js script, needs to be loaded last*}
<script src="{$geoMetadata_article_detailsJS}" type="text/javascript" defer></script>
