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

import { When, Then } from 'cypress-cucumber-preprocessor/steps';
import { HomePage } from './home-page';

const homePage: HomePage = new HomePage();

When('I go to the home page', () => {
  homePage.visit();
})

Then('I\'m on the home page', () => {
  homePage.getActiveMenuLink().contains('Home');
})

Then('Default home page text is present', () => {
  homePage.getHeroHeaderText().contains('Use the Mauro Data Mapper platform');
  homePage.getHeroHeaderFirstParagraph().contains('Automatically import your existing schemas;');
})

Then('Login button is shown', () => {
  homePage.getLogInButton().should('exist');
})