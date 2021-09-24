/**
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
 */

import { Given, Then, When } from 'cypress-cucumber-preprocessor/steps';
import { makeCatalogueItemPubliclyReadable } from '../../common/api/access-levels';
import { ensureUserIsLoggedOut, loginAsUser } from '../../common/helpers/security.helpers';
import { CataloguePage } from '../objects/catalogue-page';
import { UserGroupAccessDialog } from '../objects/dialogs/user-group-access-dialog';

const catalogue = new CataloguePage();
const userGroupAccess = new UserGroupAccessDialog();

Given(/^The selected catalogue item is not available to everyone$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getMauroData())
    .then(item => makeCatalogueItemPubliclyReadable(item.domain, item.id, false))
    .then(() => cy.reload()); // Force reload so page doesn't contain cached data
})

When(/^I mark the selected catalogue item as "Publicly readable"$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getOptionButton('user-group-access').click())
    .then(() => userGroupAccess.getUserAccessOption('shareReadWithEveryone').click());
})

Then(/^The selected catalogue item is now public for anyone to read$/, () => {
  userGroupAccess.getUserAccessOptionRawInput('shareReadWithEveryone').should('be.checked');
  userGroupAccess.getCloseButton().click();

  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getModelProperty('availability'))
    .should('contain.text', 'Publicly Readable');
})

Given(/^An administrator has marked "([^"]*)" - version: "([^"]*)" - as publicly readable$/, (label, version) => {  
  ensureUserIsLoggedOut()
    .log('Sign in as administrator')
    .then(() => loginAsUser('administrator'))
    .then(() => catalogue.visit())
    .log('Find catalogue item to display')
    .then(() => catalogue.treeView.tree.ensureExpanded(['Development Folder']))
    .then(() => catalogue.treeView.tree.getTreeNode(label, version).click())
    .log('Prepare catalogue item to be publicly readable')
    .then(() => catalogue.getCurrentlyLoadedCatalogueItemView())
    .then(page => page.getMauroData())
    .then(item => makeCatalogueItemPubliclyReadable(item.domain, item.id, true))
    .log('Sign out as administrator')
    .then(() => ensureUserIsLoggedOut())
    .then(() => cy.reload());
})

Then(/^I can read the selected catalogue item$/, () => {    
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      page.getDetailArea().should('be.visible');
      page.openUserActionsMenu();
      page.getUserActionsMenuButton('edit-label').should('not.exist');
    });
})