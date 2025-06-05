/**
 * js/issue.js
 *
 * Copyright (c) 2025 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 * 
 * @brief Display spatio-temporal metadata in the issue view. 
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

// add scale to the map 
L.control.scale({ position: 'bottomright' }).addTo(map);

// FeatureGroup for the geospatial extent of articles
var articleLocations = new L.FeatureGroup();
map.addLayer(articleLocations);

var overlayMaps = {
    [geoMetadata_layerName]: articleLocations,
};

// add layerControl to the map to the map 
L.control.layers(baseLayers, overlayMaps).addTo(map);

const iconStyle = L.icon({
    iconUrl: geoMetadata_markerBaseUrl + 'marker-icon-2x-blue.png',
    shadowUrl: geoMetadata_markerBaseUrl + 'marker-shadow.png'
});
const iconStyleHighlight = L.icon({
    iconUrl: geoMetadata_markerBaseUrl + 'marker-icon-2x-red.png',
    shadowUrl: geoMetadata_markerBaseUrl + 'marker-shadow.png'
});

// highlighting features based on https://leafletjs.com/examples/choropleth/
function highlightFeature(layer, feature) {
    if (feature && feature.geometry.type === "Point" && layer.options.icon) { // only setIcon on a layer that already has one
        layer.setIcon(iconStyleHighlight);
    } else {
        layer.setStyle(geoMetadata_mapLayerStyleHighlight);
        if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
            layer.bringToFront();
        }
    }
}

function highlightArticle(id) {
    $('#' + id).parent().closest('div').addClass('geoMetadata_title_hover');
}

function resetHighlightFeature(layer, feature) {
    if (feature && feature.geometry.type === "Point" && layer.options.icon) {
        layer.setIcon(iconStyle);
    } else {
        layer.setStyle(geoMetadata_mapLayerStyleHighlight);
        // layer.resetStyle(); // e's layers is a geoJSON layer, so maybe access that function here somehow?
        layer.setStyle(geoMetadata_mapLayerStyle);
    }
}

function resetHighlightArticle(id) {
    $('#' + id).parent().closest('div').removeClass('geoMetadata_title_hover');
}

var articleFeaturesMap = new Map();

// load spatial data
$(function () {

    // load properties for each article from issue_details.tpl
    var spatialInputs = $('.geoMetadata_data.spatial').toArray().map(input => {
        let geojson = JSON.parse(input.value);
        return (geojson);
    });
    var articleIdInputs = $('.geoMetadata_data.articleId').toArray().map(input => {
        return (input.value);
    });
    var popupInputs = $('.geoMetadata_data.popup').toArray().map(input => {
        return (input.value);
    }); 
    
    // in case no article of the issue includes spatialInput, the map is hidden
    var spatialInputsAvailable = false; 

    spatialInputs.forEach((spatialProperty, index) => {
        let articleId = articleIdInputs[index];
        var features = [];

        if(spatialProperty.features.length !== 0) {
            spatialInputsAvailable = true;
            let layer = L.geoJSON(spatialProperty, {
                onEachFeature: (feature, layer) => {
                    layer.bindPopup(popupInputs[index]);
                    layer.on({
                        mouseover: (e) => {
                            highlightFeature(e.target, feature);
                            highlightArticle(feature.properties.articleId);
                        },
                        mouseout: (e) => {
                            resetHighlightFeature(e.target, feature);
                            resetHighlightArticle(feature.properties.articleId);
                        }
                    });
                    feature.properties['articleId'] = articleId;
                    features.push(feature);
                },
                style: geoMetadata_mapLayerStyle
            });
    
            articleLocations.addLayer(layer);
            map.fitBounds(articleLocations.getBounds());
    
            // add event listener to article div for highlighting the related layer
            articleFeaturesMap.set(articleId, features);
            let articleDiv = $('#' + articleId).parent().closest('div');
            articleDiv.hover(
                (e) => {
                    let features = articleFeaturesMap.get(articleId);
                    features.forEach(f => {
                        highlightFeature(layer, f);
                    })
                },
                (e) => {
                    let features = articleFeaturesMap.get(articleId);
                    features.forEach(f => {
                        resetHighlightFeature(layer, f);
                    })
                }
            );
        }
    });

    // in case no article of the issue includes spatialInput, the map is hidden
    if (spatialInputsAvailable != true) {
        $("#geoMetadata_issueMap").hide();
    } 
});

/*
$(function () {
    // load time periods from article_details.tpl 
    var temporalPropertiesDecoded = document.getElementById("geoMetadata_temporal").value;

});
*/
