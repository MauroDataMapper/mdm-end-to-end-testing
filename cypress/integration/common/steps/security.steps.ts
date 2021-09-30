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

import {Given, Then, When} from 'cypress-cucumber-preprocessor/steps';
import { HomePage } from '../../pages/home-page/home-page';
import { ensureUserIsLoggedOut, loginAsUser } from '../helpers/security.helpers';
import {LoginForm} from "../../security/login/login-form";
import {MdmTemplatePage} from "../objects/mdm-template-page";

const loginForm = new LoginForm();
const page = new MdmTemplatePage();

Given(/^I am an anonymous user$/, () => {
  ensureUserIsLoggedOut()
    .then(() => new HomePage().visit());
});

Given(/^I am logged in as the administrator user$/, () => {
  loginAsUser('administrator')
    .then(() => new HomePage().visit());
});

Then('The login button is shown', () => {
  new HomePage().getLogInButton().should('exist');
});

Given(/^I log in with username  administrator user$/, () => {
  loginAsUser('administrator')
      .then(() => new HomePage().visit());
});

When(/^I login as "([^"]*)" with "([^"]*)"$/, (username, password) => {
  page.getLogInButton().click();
  loginForm.login(username, password);
});

Given(/^I am logged out$/, () => {
  ensureUserIsLoggedOut();
});

Then(/^I am logged in as "([^"]*)"$/, (name) => {
  page.getUserProfileImage().should('exist');
  page.getUserProfileName().contains(name);
});
