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

import { Given, Then } from 'cypress-cucumber-preprocessor/steps';
import { CataloguePage } from '../../catalogue/objects/catalogue-page';
import { makeCatalogueItemPubliclyReadable } from '../api/access-levels';
import { ensureUserIsLoggedOut, loginAsUser } from '../helpers/security.helpers';
import {HomePage} from '../../pages/home-page/home-page';

const catalogue = new CataloguePage();

Given(/^An administrator has marked "([^"]*)" - version: "([^"]*)" - as publicly readable$/, (label, version) => {
  ensureUserIsLoggedOut()
    .log('Sign in as administrator')
    .then(() => loginAsUser('administrator'))
      .then(() => new HomePage().visit())
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
});

Then(/^I cannot edit the label of the selected catalogue item$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      page.openUserActionsMenu();
      page.getUserActionsMenuButton('edit-label').should('not.exist');
    });
});