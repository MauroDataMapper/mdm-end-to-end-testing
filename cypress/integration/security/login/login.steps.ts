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
import { ensureUserIsLoggedOut } from '../../common/helpers/security.helpers';
import { MdmTemplatePage } from '../../common/objects/mdm-template-page';
import { HomePage } from '../../pages/home-page/home-page';
import { LoginForm } from './login-form';

const page = new MdmTemplatePage();
const homePage = new HomePage();
const loginForm = new LoginForm();

After(() => {
  ensureUserIsLoggedOut();
  homePage.visit();
})

Given(/^I am logged out$/, () => {
  ensureUserIsLoggedOut();
})

Given(/^I open the Log in form$/, () => {
  page.getLogInButton().click();
})

When(/^I login as "([^"]*)" with "([^"]*)"$/, (username, password) => {
  loginForm.login(username, password);
})

When(/^I login with no inputs in the form fields$/, () => {
  loginForm.login();
})

When(/^I login as "([^"]*)"$/, (username) => {
  loginForm.login(username, "password");
})

Then(/^I am logged in as "([^"]*)"$/, (name) => {  
  page.getUserProfileImage().should('exist');
  page.getUserProfileName().contains(name);
})

Then(/^I am not logged in$/, () => {
  loginForm.getForm().should('be.visible');
})

Then(/^an alert says "([^"]*)"$/, (error) => {
  loginForm.getAlert().contains(error);
})

Then(/^there are validation errors in the login form$/, () => {
  loginForm.getFormFieldValidationErrors().should('not.be.empty');
})

Then(/^I see the validation message "([^"]*)"$/, (error) => {
  loginForm.getMatchingFormFieldValidationError(error).should('be.visible');
})