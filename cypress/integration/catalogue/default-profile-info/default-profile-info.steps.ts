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
import { isModelTypeDomain } from '../../common/helpers/model.helpers';
import { CataloguePage } from '../objects/catalogue-page';
import { EditDefaultProfileDialog } from '../objects/dialogs/edit-default-profile-dialog';
import { lorem } from 'faker';
import { ConfirmationDialog } from '../objects/dialogs/confirmation-dialog';

interface DefaultProfileValues {
  description?: string;
  organisation?: string;
  author?: string;
}

const catalogue = new CataloguePage();
const editDialog = new EditDefaultProfileDialog();
const confirmationDialog = new ConfirmationDialog();

When(/^I edit the description of the selected catalogue item$/, () => {
  const description = lorem.sentence();
  cy.wrap(description).as('newDescription');

  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.startEditDescription())
    .then(() => editDialog.ensureDialogIsVisible())
    .then(() => editDialog.getEditField('description'))
    .clear()
    .type(description)
    .then(() => editDialog.getContinueButton().click());
});

When(/^I start to edit the description of the selected catalogue item but do not save$/, () => {
  const description = lorem.sentence();
  cy.wrap(description).as('newDescription');

  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.startEditDescription())
    .then(() => editDialog.ensureDialogIsVisible())
    .then(() => editDialog.getEditField('description'))
    .clear()
    .type(description)
    .then(() => editDialog.getCancelButton().click())
    .then(() => confirmationDialog.getContinueButton().click());
});

When(/^I edit the default profile fields of the selected catalogue item$/, () => {
  const newProfileValues: DefaultProfileValues = {
    description: lorem.sentence(),
    organisation: lorem.words(3),
    author: lorem.words(2)
  };

  cy.wrap(newProfileValues).as('newProfileValues');

  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.startEditAllDefaultProfile())
    .then(() => editDialog.ensureDialogIsVisible())
    .then(() => editDialog.getEditField('description'))
    .clear()
    .type(newProfileValues.description)
    .then(() => editDialog.getEditField('organisation'))
    .clear()
    .type(newProfileValues.organisation)
    .then(() => editDialog.getEditField('author'))
    .clear()
    .type(newProfileValues.author)
    .then(() => editDialog.getContinueButton().click());
});

When(/^I start to edit the default profile fields of the selected catalogue item but do not save$/, () => {
  const newProfileValues: DefaultProfileValues = {
    description: lorem.sentence(),
    organisation: lorem.words(3),
    author: lorem.words(2)
  };

  cy.wrap(newProfileValues).as('newProfileValues');

  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.startEditAllDefaultProfile())
    .then(() => editDialog.ensureDialogIsVisible())
    .then(() => editDialog.getEditField('description'))
    .clear()
    .type(newProfileValues.description)
    .then(() => editDialog.getEditField('organisation'))
    .clear()
    .type(newProfileValues.organisation)
    .then(() => editDialog.getEditField('author'))
    .clear()
    .type(newProfileValues.author)
    .then(() => editDialog.getCancelButton().click())
    .then(() => confirmationDialog.getContinueButton().click());
});

Then(/^I can see the selected catalogue item's default profile$/, () => {
  catalogue.getCurrentTrackedView()
    .then(view => view.page.getTab('Description').click().wrap(view))
    .then(view => {
      view.page.getProfileSelector().should('contain.text', 'Default profile');

      view.page.getDefaultProfileProperty('description').should('be.visible');

      if (isModelTypeDomain(view.data.domain)) {
        view.page.getDefaultProfileProperty('aliases').should('be.visible');
        view.page.getDefaultProfileProperty('author').should('be.visible');
        view.page.getDefaultProfileProperty('organisation').should('be.visible');
        view.page.getDefaultProfileProperty('classifications').should('be.visible');
      }
    });
});

Then(/^I cannot modify the selected catalogue item's default profile$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => page.getDefaultProfileEditButton().should('not.exist'));
});

Then(/^The new description appears in the selected catalogue item$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      return cy.get<string>('@newDescription')
        .then(desc => cy.wrap({
          page,
          newDescription: desc
        }));
    })
    .then(data => {
      data.page
        .getDefaultProfileProperty('description')
        .should('contain.text', data.newDescription);
    });
});

Then(/^The description is unchanged$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      return cy.get<string>('@newDescription')
        .then(desc => cy.wrap({
          page,
          newDescription: desc
        }));
    })
    .then(data => {
      data.page
        .getDefaultProfileProperty('description')
        .should('not.contain.text', data.newDescription);
    });
});

Then(/^The new default profile values appears in the selected catalogue item$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      return cy.get<DefaultProfileValues>('@newProfileValues')
        .then(values => cy.wrap({
          page,
          newProfileValues: values
        }));
    })
    .then(data => {
      data.page
        .getDefaultProfileProperty('description')
        .should('contain.text', data.newProfileValues.description);

      data.page
        .getDefaultProfileProperty('organisation')
        .should('contain.text', data.newProfileValues.organisation);

      data.page
        .getDefaultProfileProperty('author')
        .should('contain.text', data.newProfileValues.author);
    });
});

Then(/^The default profile fields are unchanged$/, () => {
  catalogue.getCurrentlyLoadedCatalogueItemView()
    .then(page => {
      return cy.get<DefaultProfileValues>('@newProfileValues')
        .then(values => cy.wrap({
          page,
          newProfileValues: values
        }));
    })
    .then(data => {
      data.page
        .getDefaultProfileProperty('description')
        .should('not.contain.text', data.newProfileValues.description);

      data.page
        .getDefaultProfileProperty('organisation')
        .should('not.contain.text', data.newProfileValues.organisation);

      data.page
        .getDefaultProfileProperty('author')
        .should('not.contain.text', data.newProfileValues.author);
    });
});