/**
 * js/journal.js
 *
 * Copyright (c) 2025 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 * 
 * @brief Display spatio-temporal metadata for a whole journal on a separate page.
 */

var mapView = "0, 0, 1".split(",");
var map = L.map('mapdiv').setView([mapView[0], mapView[1]], mapView[2]);

var osmlayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data: &copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors',
    maxZoom: 18
}).addTo(map);

var Esri_WorldImagery = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
    attribution: 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
    maxZoom: 18
});

var baseLayers = {
    "OpenStreetMap": osmlayer,
    "Esri World Imagery": Esri_WorldImagery
};

L.control.scale({ position: 'bottomright' }).addTo(map);

// FeatureGroup for the geospatial extent of articles
var articleLocations = new L.FeatureGroup();
map.addLayer(articleLocations);

var overlayMaps = {
    [geoMetadata_layerName]: articleLocations,
};

// add layerControl to the map to the map 
L.control.layers(baseLayers, overlayMaps).addTo(map);

// load spatial data
$(function () {
    // load properties for each article from issue_map.tpl
    var data = JSON.parse($('.geoMetadata_data.publications')[0].value);
    
    data.forEach((publication, index) => {
        let submissionId = publication['submissionId'];
        
        if (publication['spatial'] != null) {
            let spatialParsed = JSON.parse(publication['spatial']);

            if(spatialParsed.features.length !== 0) {
                let articleTitle = publication['title'];
                let articleAuthors = publication['authors'];
                let articleIssue = publication['issue'];
                let articleTemporal = publication ['temporal'];
                let articleAdministrativeUnit = publication['coverage'];

                // popup content roughly based on issue_details.tpl
                let popupTemplate = `<h2 class="title">
                    <a id="submission-${submissionId}" class="geoMetadata_journal_maplink" href="${geoMetadata_articleBaseUrl}/${submissionId}">${articleTitle}</a>
                    </h2>
                    <br/>
                    <div class="authors">
                        ${articleAuthors}
                    </div>
                    <div class="authors">
                        ${articleIssue}
                    </div>`

                if (articleTemporal !== "no data" && articleTemporal !== null) {
                    let articleTemporalStart = articleTemporal.split('{')[1].split('..')[0];
                    let articleTemporalEnd = articleTemporal.split('{')[1].split('..')[1].split('}')[0];

                    let popupTemporal = `<br/>
                    <div class="authors">
                        <i class="fa-solid fa-calendar-days"></i>
                        <i>${articleTemporalStart} – ${articleTemporalEnd}</i>
                    </div>`

                    popupTemplate = popupTemplate.concat(popupTemporal);
                }

                if (articleAdministrativeUnit !== "no data" && articleAdministrativeUnit !== null) {
                    let popupAdministrativeUnit = `<br/>
                    <div class="authors"> 
                        <i class="fa-solid fa-location-dot"></i>
                        <i>${articleAdministrativeUnit}</i>
                    </div>`

                    popupTemplate = popupTemplate.concat(popupAdministrativeUnit);
                }

                let layer = L.geoJSON(spatialParsed, {
                    onEachFeature: (feature, layer) => {
                        layer.bindPopup(`${popupTemplate}`);
                    },
                    style: geoMetadata_mapLayerStyle,
                    submissionId: submissionId
                });
                articleLocations.addLayer(layer);
                map.fitBounds(articleLocations.getBounds());
            }
        }
        // TODO load temporal properties and add them to a timeline
    });
});
