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

import { After, Given, Then, When } from 'cypress-cucumber-preprocessor/steps';

When(/^I mark the selected catalogue item as "Publicly readable"$/, () => {
  // TODO:
  // Model tree selection needs to include cy.as() call
  // Open "User & Group Access" dialog
  // Tick "Publicly readable"
  throw new Error();
})

Then(/^The selected catalogue item is now public for anyone to read$/, () => {
  // TODO
  // Model tree selection needs to include cy.as() call
  // Model property now includes "Availability: Publicly Readable"
  throw new Error();
})

After({ tags: '@scenario-teardown' }, () => {
  // TODO
  // Model tree selection needs to include cy.as() call
  // Find id of catalogue item
  // Send REST call to remove "publicly readable" status
})

Given(/^An administrator has marked "([^"]*)" - version: "([^"]*)" - as publicly readable$/, (label, version) => {
  // TODO
  // Login as admin
  // Navigate tree to select chosen catalogue item
  // Find out id of catalogue item - will need to update UI to add catalogue item id as data attribute somewhere
  // Send REST call to add "publicly readable" status
  // Sign out
  throw new Error();
})

Then(/^I can read the selected catalogue item$/, () => {
  // TODO
  // Model tree selection needs to include cy.as() call
  // Check the catalogue item is in detail view
  throw new Error();
})

Then(/^I cannot edit the selected catalogue item$/, () => {
  // TODO
  // Model tree selection needs to include cy.as() call
  // Check edit controls do not exist
  throw new Error();
})