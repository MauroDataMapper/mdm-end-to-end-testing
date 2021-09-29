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

import { Then, When } from 'cypress-cucumber-preprocessor/steps';
import { ModelTreeNodeSelection } from '../../common/helpers/model.helpers';
import { InlineLabelEditButton } from '../objects/catalogue-item-page';
import { CataloguePage } from '../objects/catalogue-page';

const labelTestSuffix = '_Test1';
const catalogue = new CataloguePage();

const triggerLabelEdit = (text: string, action: InlineLabelEditButton) => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      page.openUserActionsMenu()
        .then(() => page.getUserActionsMenuButton('edit-label').click());

      page.getLabelInlineEditField()
        .clear()
        .type(text)
        .then(() => page.getLabelInlineEditButton(action))
        .click();
    });
};

When(/^I change the selected catalogue item label$/, () => {
  cy.get<ModelTreeNodeSelection>('@currentItem')
    .then(item => triggerLabelEdit(item.label + labelTestSuffix, 'save'));
});

When(/^I start changing the label of the selected catalogue item but then cancel$/, () => {
  cy.get<ModelTreeNodeSelection>('@currentItem')
    .then(item => triggerLabelEdit(item.label + labelTestSuffix, 'cancel'));
});

When(/^I clear all text for the label of the selected catalogue item$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      page.openUserActionsMenu()
        .then(() => page.getUserActionsMenuButton('edit-label').click());

      page.getLabelInlineEditField().clear();
    });
});

Then(/^The selected catalogue item will be updated successfully$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getLabelText().should('contain.text', labelTestSuffix));
});

Then(/^The selected catalogue item label is reverted back$/, () => {
  cy.get<ModelTreeNodeSelection>('@currentItem')
    .then(item => triggerLabelEdit(item.label, 'save'));
});

Then(/^The selected catalogue item has not been updated$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getLabelText().should('not.contain.text', labelTestSuffix));
});

Then(/^I am unable to save the changes made$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getLabelInlineEditButton('save').should('be.disabled'));
});