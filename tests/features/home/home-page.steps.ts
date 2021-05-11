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
import { browser } from 'protractor';
import { MenuBarPage } from '../../pages/menuBarPage';

const menuBarPage: MenuBarPage = new MenuBarPage();

When('I go to the home page', async function () {
  await browser.get(browser.baseUrl + '/#/home');
})

Then('I\'m on the home page', async function () {
  expect(await menuBarPage.getActiveMenuLink().getText()).to.equal('Home');
})

Then('Default home page text is present', async function () {
  expect(await menuBarPage.getMainTextHeader().getText()).to.contain('Use the Mauro Data Mapper platform')
  expect(await menuBarPage.getMainTextFirstParagraph().getText()).to.contain('Automatically import your existing schemas;')
})

Then('Login Button is shown', async function () {
  expect(await menuBarPage.getLoginButton().isPresent())
})