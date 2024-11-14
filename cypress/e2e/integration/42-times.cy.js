/**
 * @file cypress/tests/integration/html_head.cy.js
 *
 * Copyright (c) 2024 KOMET project, OPTIMETA project, Daniel Nüst, Tom Niers
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 */

describe('geoMetadata Time Periods', function () {

  it('has the time period for the article on the article page', function () {    
    cy.visit('/');
    cy.get('nav[class="pkp_site_nav_menu"] a:contains("Archive")').click();
    cy.get('a:contains("Vol. 1 No. 2 (2022)")').click();
    cy.get('a:contains("Hanover is nice")').last().click();
    cy.get('#geoMetadata_span_start').should('contain', '2022-01-01');
    cy.get('#geoMetadata_span_end').should('contain', '2022-12-31');
  });

});