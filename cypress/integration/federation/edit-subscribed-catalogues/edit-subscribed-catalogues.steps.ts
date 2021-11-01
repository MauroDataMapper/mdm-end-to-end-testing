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

import { Then, When, And, Given } from 'cypress-cucumber-preprocessor/steps';
import { SubscribedCataloguePage } from '../subscribed-catalogues-page';
import { AddSubscribedCatalogueForm } from '../add-subscribed-catalogue-form';

const page = new SubscribedCataloguePage();
const form = new AddSubscribedCatalogueForm();

And(/^I am on the subscribed catalogues page$/, () => {
  page.visit();
});

Given(/^I click the add button$/, () => {
  page.getAddButton().click();
});

When(/^I enter "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" and "([^"]*)"$/, (label, description, url, apiKey, refreshPeriod) => {
  this.label = label;
  this.url = url;

  form.getLabelField().type(label);
  if (description) {
    form.getDescriptionField().type(description);
  }
  form.getUrlField().type(url);
  if (apiKey) {
    form.getApiKeyField().type(apiKey);
  }
  if (refreshPeriod) {
    form.getRefreshPeriodField().type(refreshPeriod);
  }
});

And(/^I click the add subscription button$/, () => {
  form.getAddSubscriptionButton().click();
});

Then(/^The subscribed catalogue is added successfully$/, () => {
  page.getToastMessage('Subscribed catalogue saved successfully');
  page.getSubscribedCatalogueRow(this.label, this.url);
});

Then(/^The subscription is deleted using the delete button$/, () => {
  page.getSubscribedCatalogueMenuButton(this.label, this.url).click();
  page.getSubscribedCatalogueMenuItem('Delete subscription').click();
  page.getButton('Yes, delete').click();
  page.getToastMessage('Subscribed catalogue deleted successfully');
});

Then(/^There is an error adding the subscription$/, () => {
  page.getToastMessage('Invalid subscription to catalogue at');
});

When(/^I click the test subscription button$/, () => {
  cy.get('@subscribedCatalogueMap').then((subscribedCatalogueMap) => {
    page.getSubscribedCatalogueMenuButton(subscribedCatalogueMap.label, subscribedCatalogueMap.url).click();
  });
  page.getSubscribedCatalogueMenuItem('Test subscription').click();
});

Then(/^The test is successful$/, () => {
  page.getToastMessage(/Subscribed catalogue "([^"]*)" is functioning as expected./);
});