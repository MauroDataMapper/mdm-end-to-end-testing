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

import { Then, When, And } from 'cypress-cucumber-preprocessor/steps';
import { subscribedCatalogueModelMap } from '../../common/api/federation.api';
import { CataloguePage } from '../../catalogue/objects/catalogue-page';
import { SubscribedModelPage } from '../subscribed-model-page';
import { DataModelPage } from '../../catalogue/objects/models/data-model-page';

const cataloguePage = new CataloguePage();
const subscribedModelPage = new SubscribedModelPage();
const dataModelPage = new DataModelPage();

When(/^I expand External catalogues$/, () => {
  cataloguePage.treeView.tree.ensureExpanded(['External catalogues']);
});

When(/^I expand an external catalogue with a model$/, () => {
  cy.get('@subscribedCatalogueMap').then((subscribedCatalogueMap) => {
    cataloguePage.treeView.tree.ensureExpanded([subscribedCatalogueMap.label]);
  });
});

And(/^I click on a model in the external catalogue$/, () => {
  cataloguePage.treeView.tree.getTree().contains('mat-tree-node div.mat-tree-node-content', subscribedCatalogueModelMap.publishedLabel).click();
});

Then(/^The external model is displayed$/, () => {
  subscribedModelPage.getDetailArea().find('h4').contains(subscribedCatalogueModelMap.publishedLabel);
});

When(/^I click the Subscribe button$/, () => {
  subscribedModelPage.getButton('Subscribe').click();
});

Then(/^The subscription is successful$/, () => {
  subscribedModelPage.getToastMessage('Successfully subscribed to data model');
});

And(/^I select the "Development Folder" and click Subscribe$/, () => {
  subscribedModelPage.getFolderSearchInput().click();
  subscribedModelPage.getSubscriptionModalFolder('Development Folder').click();
  subscribedModelPage.getSubscriptionModalButton('Subscribe').click();
});

When(/^I click on the subscribed model in the model tree$/, () => {
  cy.wait(1000); /* Wait until the model tree is refreshed */
  cataloguePage.treeView.tree.collapseTreeNode('External catalogues');
  cataloguePage.treeView.tree.ensureExpanded(['This catalogue', 'Development Folder']);
  cataloguePage.treeView.tree.getTreeNode(subscribedCatalogueModelMap.label, subscribedCatalogueModelMap.version).click();
});

Then(/^The model is displayed$/, () => {
  dataModelPage.getLabel().contains(subscribedCatalogueModelMap.label);
});

When(/^I click the Unsubscribe button$/, () => {
  dataModelPage.getButton('Unsubscribe').click();
});

And(/^I click the Yes, unsubscribe button$/, () => {
  dataModelPage.getButton('Yes, unsubscribe').click();
});

Then(/^The unsubscription is successful$/, () => {
  dataModelPage.getToastMessage('Successfully unsubscribed from data model');
});

Then(/^The imported model is deleted$/, () => {
  cataloguePage.treeView.tree.ensureExpanded(['Development Folder']);
  cataloguePage.treeView.tree.getTreeNode(subscribedCatalogueModelMap.label, subscribedCatalogueModelMap.version).click();
  dataModelPage.openUserActionsMenu();
  dataModelPage.expandUserActionsSubMenu('delete-options-menu');
  dataModelPage.getUserActionsMenuButton('permanent-delete').click();
  dataModelPage.getButton('Yes, delete').click();
  dataModelPage.getButton('Confirm deletion').click();
  cy.wait(1000); /* Wait until the model tree is refreshed */
  cataloguePage.treeView.tree.getTree().contains('mat-tree-node div.mat-tree-node-content', subscribedCatalogueModelMap.label).should('not.exist');
});