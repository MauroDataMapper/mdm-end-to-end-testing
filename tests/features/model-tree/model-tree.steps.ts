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

import { Given, Then, When } from '@cucumber/cucumber';
import { expect } from 'chai';
import { browser } from 'protractor';
import { loginUser } from '../../helpers/login';
import { navigateTo } from '../../helpers/navigation';
import { CataloguePage } from '../../objects/catalogue-page';
import { ModelTreeView } from './model-tree-view';

const cataloguePage = new CataloguePage();
const modelTree = new ModelTreeView();

Given(/^I am logged in$/, async function () {
  await loginUser('administrator');
});

When(/^I browse the catalogue$/, async function () {
  await navigateTo(cataloguePage);
});

When(/^I click on a model in the model tree$/, async function () {
  await modelTree.tree.ensureExpanded(['Development Folder']);

  const modelNode = await modelTree.tree.getMatTreeNode('Complex Test DataModel');
  await browser.wait(() => modelNode.elem.isPresent());

  await modelNode.click();
});

Then(/^I see the model tree$/, async function () {
  expect(await browser.wait(() => modelTree.isPresent())).to.be.true;
});

Then(/^the detail view is empty$/, async function () {
  expect(await browser.wait(() => cataloguePage.getDefaultDetailView().isPresent())).to.be.true;
});

Then(/^the detail view shows the selected model$/, async function () {
  expect(await browser.wait(() => cataloguePage.isDetailViewDisplayingModel('Complex Test DataModel').isPresent())).to.be.true;
});