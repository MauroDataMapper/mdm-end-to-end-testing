/*
 * Copyright 2021 University of Oxford
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import { Then, When } from 'cypress-cucumber-preprocessor/steps';
import { CataloguePage } from '../../catalogue/objects/catalogue-page';
import { CatalogueItemPage } from '../../catalogue/objects/catalogue-item-page';
import { subscribedCatalogueModelMap } from '../../common/api/federation.api';

const cataloguePage = new CataloguePage();
const catalogueItemPage = new CatalogueItemPage('mdm-subscribed-catalogue-main', 'mdm-subscribed-catalogue-detail');

When(/^I expand External catalogues$/, () => {
  cataloguePage.treeView.tree.ensureExpanded(['External catalogues']);
});

Then(/^I see the external catalogues$/, () => {
  cy.get('@subscribedCatalogueMap').then((subscribedCatalogueMap) => {
    cy.contains('mat-tree-node', subscribedCatalogueMap.label);
  });
});

When(/^I click on an external catalogue (with|without) a model$/, () => {
  cy.get('@subscribedCatalogueMap').then((subscribedCatalogueMap) => {
    cataloguePage.treeView.tree.getTreeNode(subscribedCatalogueMap.label).click();
  });
});

Then(/^The external catalogue is displayed$/, () => {
  cy.get('@subscribedCatalogueMap').then((subscribedCatalogueMap) => {
    catalogueItemPage.getDetailArea().find('h4').contains(subscribedCatalogueMap.label);
  });
});

When(/^I expand the external catalogue$/, () => {
  cataloguePage.treeView.tree.collapseTreeNode('This catalogue');
  cy.get('@subscribedCatalogueMap').then((subscribedCatalogueMap) => {
    cataloguePage.treeView.tree.expandTreeNode(subscribedCatalogueMap.label);
  });
});

Then(/^I see a model in the external catalogue$/, () => {
  cataloguePage.treeView.tree.getTree().contains('mat-tree-node div.mat-tree-node-content', subscribedCatalogueModelMap.publishedLabel);
});

Then(/^I see no model in the external catalogue$/, () => {
  cataloguePage.treeView.tree.getTree().find('mat-tree-node div.mat-tree-node-content mat-icon.fa-external-link-alt').should('not.exist');
});