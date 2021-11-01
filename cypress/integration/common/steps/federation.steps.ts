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

import { Given, Then } from 'cypress-cucumber-preprocessor/steps';
import { createSubscription, deleteSubscription, subscribedCatalogueMapWithModel, subscribedCatalogueMapWithoutModel } from '../api/federation.api';

Given(/^There is a subscription to a subscribed catalogue with an API key|There is a subscription to a subscribed catalogue with a published model$/, () => {
  cy.wrap(subscribedCatalogueMapWithModel).as('subscribedCatalogueMap');

  createSubscription(subscribedCatalogueMapWithModel).as('subscribedCatalogueSave');
  cy.get('@subscribedCatalogueSave').should('have.property', 'status', 201);
  cy.reload();
});

Given(/^There is a subscription to a subscribed catalogue without an API key|There is a subscription to a subscribed catalogue without a published model$/, () => {
  cy.wrap(subscribedCatalogueMapWithoutModel).as('subscribedCatalogueMap');

  createSubscription(subscribedCatalogueMapWithoutModel).as('subscribedCatalogueSave');
  cy.get('@subscribedCatalogueSave').should('have.property', 'status', 201);
  cy.reload();
});

Then(/^The subscription is deleted$/, () => {
  cy.get('@subscribedCatalogueSave').its('body.id').then((id) => {
    deleteSubscription(id).should('have.property', 'status', 204);
  });
});