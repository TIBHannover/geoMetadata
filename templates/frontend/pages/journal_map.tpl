{**
 * templates/frontend/pages/journal_map.tpl
 *
 * Copyright (c) 2025 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Display the page to view geospatial metadata for a journal.
 *
 * @uses $journal The name of the journal currently being viewed
 * @uses $publications JSON-encoded array with all data for the map
 *}

{include file="frontend/components/header.tpl" pageTitle="plugins.generic.geoMetadata.journal.pageTitle"}

<script type="text/javascript">
const geoMetadata_mapLayerStyle = {
    weight: 5,
    color: '#1E6292',
    dashArray: '',
    fillOpacity: 0.6
};

const geoMetadata_layerName = '{translate key="plugins.generic.geoMetadata.map.articleLayerName"}';
const geoMetadata_articleBaseUrl = '{if $journal}{url journal=$journal->getPath() page="article" op="view" path=""}{else}{url page="article" op="view" path=""}{/if}';
</script>

<link rel="stylesheet" href="{$pluginStylesheetURL}styles.css" type="text/css" />

<input type="text" class="geoMetadata_data publications" name="publications"
    style="height: 0px; width: 0px; visibility: hidden;" value='{$publications}'>

<div class="page page_about_publishing_system">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="plugins.generic.geoMetadata.journal.breadcrump"}
	<h1>{translate key="plugins.generic.geoMetadata.journal.title"} {$context}</h1>
	<p>{translate key="plugins.generic.geoMetadata.journal.text"}</p>

	<div id="mapdiv" style="width: 100%; height: 480px; z-index: 1;"></div>

	<p class="geoMetadata_license">
		{translate key="plugins.generic.geoMetadata.license.frontend"} {$geoMetadata_metadataLicense}
	</p>
</div><!-- .page -->

{*main js script, needs to be loaded last*}
<script src="{$geoMetadata_journalJS}" type="text/javascript" defer></script>

{include file="frontend/components/footer.tpl"}
