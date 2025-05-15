{**
 * templates/frontend/objects/issue_details.tpl
 *
 * Copyright (c) 2024 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * @brief Embed geospatial metadata in hidden fields for use on the issue map.
 *
 * The main template is here extended using the hook 'Templates::Issue::Issue::Article'.
 *}

<input type="text" class="geoMetadata_data articleId" name="articleId"
    style="height: 0px; width: 0px; visibility: hidden;" value='article-{$article->getId()}'>
<input type="text" class="geoMetadata_data spatial" name="{$smarty.const.GEOMETADATA_DB_FIELD_SPATIAL}"
    style="height: 0px; width: 0px; visibility: hidden;" value='{${$smarty.const.GEOMETADATA_DB_FIELD_SPATIAL}}'>
<input type="text" class="geoMetadata_data popup" name="mapPopup"
    style="height: 0px; width: 0px; visibility: hidden;" value='
		<{$heading} class="title">
		<a id="article-{$article->getId()}" class="geoMetadata_issue_maplink" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
			{$article->getLocalizedTitle()|strip_unsafe_html}
			{if $article->getLocalizedSubtitle()}
				<span class="subtitle">
					{$article->getLocalizedSubtitle()|escape}
				</span>
			{/if}
		</a>
		</{$heading}>
		<br/>
		{if $showAuthor}
			<div class="authors">
				{$article->getAuthorString()|escape}
			</div>
		{/if} 
		<p></p>
		<i class="fa-solid fa-calendar-days"></i>
		<i>{$publication->getData(GEOMETADATA_DB_FIELD_TIME_PERIODS)|escape|replace:'..':' – '|replace:'{':''|replace:'}':''}</i>
		<p></p>
		<i class="fa-solid fa-location-dot"></i>
		<i>{$article->getCoverage($journal->getPrimaryLocale())|escape}</i>
	'>

{* <input type="text" class="geoMetadata_data temporal" name="{$smarty.const.GEOMETADATA_DB_FIELD_TIME_PERIODS}"
    style="height: 0px; width: 0px; visibility: hidden;" value='{${$smarty.const.GEOMETADATA_DB_FIELD_TIME_PERIODS}}' /> *}
{* <input type="text" class="geoMetadata_data administrativeUnit" naissueme="{$smarty.const.GEOMETADATA_DB_FIELD_ADMINUNIT}"
    style="height: 0px; width: 0px; visibility: hidden;" value='{${$smarty.const.GEOMETADATA_DB_FIELD_ADMINUNIT}}' /> *}
