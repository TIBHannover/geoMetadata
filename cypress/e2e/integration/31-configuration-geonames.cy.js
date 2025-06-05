/**
 * @file cypress/tests/integration/configuration.cy.js
 *
 * Copyright (c) 2025 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 */

describe('geoMetadata Configuration Geonames', function () {

  it('Configure geoMetadata - Geonames', function () {
    cy.login('admin', 'admin', Cypress.env('contextPath'));
    cy.get('nav[class="app__nav"] a:contains("Website")').click();
    cy.get('button[id="plugins-button"]').click();

    // Open the settings form
    cy.get('tr[id="component-grid-settings-plugins-settingsplugingrid-category-generic-row-geoMetadata"] a[class="show_extras"]').click();
    cy.get('a[id^="component-grid-settings-plugins-settingsplugingrid-category-generic-row-geoMetadata-settings-button"]').click();

    // Fill out settings form
    cy.get('form[id="geoMetadataSettings"] input[name="geoMetadata_geonames_username"]')
      .clear().invoke('val', '') // https://stackoverflow.com/a/61101054
      .type('geoMetadata');
    cy.get('form[id="geoMetadataSettings"] input[name="geoMetadata_geonames_baseurl"]')
      .clear()
      .type('http://api.geonames.org');

    // submit settings form
    cy.get('form[id="geoMetadataSettings"] button[id^="submitFormButton"]').click();
    //cy.waitJQuery();
  });

});
