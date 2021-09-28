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

import { After, Then, When } from 'cypress-cucumber-preprocessor/steps';
import { editLabel } from '../../../common/api/catalogue-items';
import { getModelTree } from '../../../common/api/model-tree';
import { DataModelPage } from '../../objects/models/data-model-page';

const labelTestSuffix = '_Test1';
const page = new DataModelPage();

After({ tags: '@teardown-reset-labels' }, () => {
  cy.log('Resetting catalogue item labels back to originals');
  getModelTree()
    .then(response => {
      const folder = response.body.find(node => node.domainType === 'Folder' && node.label === 'Development Folder');
      expect(folder, '"Development Folder" must exist').not.be.undefined;
      return cy.wrap(folder);
    })
    .then(folder => cy.wrap(folder.children?.filter(node => node.domainType === 'DataModel' && node.label.includes(labelTestSuffix))))
    .then(items => {
      items?.forEach(item => editLabel(item.id, item.domainType, item.label.replace(labelTestSuffix, '')));
    })
    .reload();
});

When(/^I change the selected catalogue item label$/, () => {
  page.openUserActionsMenu()
    .then(() => page.getUserActionsMenuButton('edit-label').click());

  page.getLabelInlineEditField()
    .type(labelTestSuffix)
    .then(() => page.getLabelInlineEditButton('save'))
    .click();
});

When(/^I start changing the label of the selected catalogue item but then cancel$/, () => {
  page.openUserActionsMenu()
    .then(() => page.getUserActionsMenuButton('edit-label').click());

  page.getLabelInlineEditField()
    .type(labelTestSuffix)
    .then(() => page.getLabelInlineEditButton('cancel'))
    .click();
});

When(/^I clear all text for the label of the selected catalogue item$/, () => {
  page.openUserActionsMenu()
    .then(() => page.getUserActionsMenuButton('edit-label').click());

  page.getLabelInlineEditField().clear();
});

Then(/^The selected catalogue item will be updated successfully$/, () => {
  page.getLabelText().should('contain.text', labelTestSuffix);
});

Then(/^The selected catalogue item has not been updated$/, () => {
  page.getLabelText().should('not.contain.text', labelTestSuffix);
});

Then(/^I am unable to save the changes made$/, () => {
  page.getLabelInlineEditButton('save').should('be.disabled');
});