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
import { isModelTypeDomain } from '../../common/helpers/model.helpers';
import { CataloguePage } from '../objects/catalogue-page';


const catalogue = new CataloguePage();

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