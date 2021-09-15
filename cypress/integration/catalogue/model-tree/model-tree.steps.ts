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
import { CataloguePage } from '../catalogue-page';

const page = new CataloguePage();

Given(/^I am on the main catalogue browsing page$/, () => {
  page.visit();
})

When(/^I click on "([^"]*)" with version "([^"]*)" in the model tree$/, (label, version) => {
  page.treeView.tree.ensureExpanded(['Development Folder']);
  page.treeView.tree.getTreeNode(label, version).click();
})

Then(/^I see the model tree$/, () => {
  page.treeView.ensureIsVisible();
})

Then(/^The catalogue item detail view is empty$/, () => {
  page.getDefaultCatalogueItemDetailView().should('be.visible');
})

Then(/^The catalogue item detail view displays "([^"]*)" of type "([^"]*)"$/, (label, type) => {
  page.isDetailViewDisplayingModel(label, type).should('be.visible');
})