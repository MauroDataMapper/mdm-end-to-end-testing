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
import { DataModelPage } from '../data-model-page';

const page = new DataModelPage();

Then(/^The catalogue item with the name "([^"]*)" is displayed$/, (label) => {
  page.getLabel().should('contain.text', label);
})

Then(/^The draft badge is displayed with no model version$/, () => {
  page.getModelStatus().should('contain.text', 'Draft');
  page.getModelProperty('model-version').should('not.exist');
})

Then(/^The finalised badge is displayed with the matching model version "([^"]*)"$/, (version) => {
  page.getModelStatus().should('contain.text', 'Finalised');
  page.getModelProperty('model-version').should('contain.text', version);
})