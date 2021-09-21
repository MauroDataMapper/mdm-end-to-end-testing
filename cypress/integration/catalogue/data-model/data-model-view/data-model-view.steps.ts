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

import { Then } from 'cypress-cucumber-preprocessor/steps';
import { isMainBranch } from '../../../common/helpers/model.helpers';
import { DataModelPage } from '../data-model-page';

const page = new DataModelPage();

Then(/^The catalogue item with the name "([^"]*)" is displayed$/, (label) => {
  page.getLabel().should('contain.text', label);
})

Then(/^I can see all the catalogue item details$/, () => {
  page.getModelProperty('item-type').should('be.visible');
  page.getModelProperty('authority').should('be.visible');
  page.getModelProperty('documentation-version').should('be.visible');
  page.getModelProperty('branch').should('be.visible');
})

Then(/^I can see all the standard options available$/, () => {
  page.getOptionButton('favourite-toggle').should('be.visible');
  page.getOptionButton('search').should('be.visible');
  page.getOptionButton('export-menu').should('be.visible');
  page.getOptionButton('user-group-access').should('be.visible');
  page.getOptionButton('user-actions-menu').should('be.visible');

  page.openUserActionsMenu();
  page.getUserActionsMenuButton('merge-graph').should('be.visible');
  page.getUserActionsMenuButton('delete-options-menu').should('be.visible');

  page.expandUserActionsSubMenu('delete-options-menu');
  page.getUserActionsMenuButton('soft-delete').should('be.visible');
  page.getUserActionsMenuButton('permanent-delete').should('be.visible');
  page.collapseUserActionsSubMenu('delete-options-menu');

  page.closeOverlayMenu();
})

Then(/^The draft badge is displayed with no model version$/, () => {
  page.getModelStatus().should('contain.text', 'Draft');
  page.getModelProperty('model-version').should('not.exist');
})

Then(/^I can see all the draft options available$/, () => {
  page.openUserActionsMenu();
  page.getUserActionsMenuButton('edit-label').should('be.visible');

  page.getCurrentBranch()
    .then(elem => {
      if (isMainBranch(elem.text())) {
        page.getUserActionsMenuButton('finalise').should('be.visible');
      }      
      else {
        page.getUserActionsMenuButton('merge').should('be.visible');
      }
    })
    .then(() => page.closeOverlayMenu());
})

Then(/^The finalised badge is displayed with the matching model version "([^"]*)"$/, (version) => {
  page.getModelStatus().should('contain.text', 'Finalised');
  page.getModelProperty('model-version').should('contain.text', version);
})

Then(/^I can see all the finalised options available$/, () => {  
  page.openUserActionsMenu();
  page.getUserActionsMenuButton('create-new-version').should('be.visible');
  page.closeOverlayMenu();
})