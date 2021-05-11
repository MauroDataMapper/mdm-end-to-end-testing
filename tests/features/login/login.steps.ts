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

import { Then, When } from '@cucumber/cucumber';
import { expect } from 'chai';
import { browser, $ } from 'protractor';
import { MdmTemplatePage } from '../../objects/mdm-template-page';
import { LoginForm } from './login-form';

const page: MdmTemplatePage = new MdmTemplatePage();
const loginForm: LoginForm = new LoginForm();

When(/^I login as "([^"]*)" with password "([^"]*)"$/, async function (username, password) {
  await page.getLoginButton().click()
  await loginForm.getEmailField().sendKeys(username);
  await loginForm.getPasswordField().sendKeys(password);
  await loginForm.getLoginButton().click();
  await browser.wait(function () {
    return page.getUserProfileImage().isPresent();
  });
});

When(/^I open the Log in form$/, async function () {
  await page.getLoginButton().click();
});

When(/^I leave all form fields empty$/, async function() {
  await loginForm.getEmailField().clear();
  await loginForm.getPasswordField().clear();
});

When(/^Click the Log in button$/, async function() {
  await loginForm.getLoginButton().click();
});

Then(/^I am logged in as "([^"]*)"$/, async function (username) {
  expect(await page.getUserNameField().getText()).to.equal(username);
});

Then(/^I am not logged in$/, async function() {
  expect(await loginForm.getForm().isDisplayed()).to.be.true;
});

Then(/^There are validation errors in the login form$/, async function() {
  expect(loginForm.getValidationErrors()).to.not.be.empty;
});

Then('Logout', async function () {
  await page.getUserNameField().click();
  await page.logout();
  expect(await page.getLoginButton()).not.null;
});