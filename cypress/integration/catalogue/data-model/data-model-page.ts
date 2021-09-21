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

import { MdmTemplatePage } from '../../common/objects/mdm-template-page';

export type ModelPropertyIdentifier = 
  'item-type'
  | 'availability'
  | 'authority'
  | 'documentation-version'
  | 'model-version'
  | 'branch';

export type CatalogueItemDetailOption =
  'user-actions-menu'
  | 'user-group-access'
  | 'export-menu'
  | 'search'
  | 'favourite-toggle';

export type UserActionMenuIdenfitier =
  'top-level-user-actions'
  | 'delete-actions';

export type UserActionsMenuOption = 
  'finalise'
  | 'edit-label'
  | 'compare'
  | 'create-new-version'
  | 'merge'
  | 'merge-graph'
  | 'restore'
  | 'delete-options-menu'
  | 'soft-delete'
  | 'permanent-delete';

export type UserActionsSubMenuOption = 
  'delete-options-menu';

export class DataModelPage extends MdmTemplatePage {
  getDetailArea() {
    return cy.get('mdm-data-model')
      .find('mdm-data-model-detail');
  }

  getLabel() {
    return this.getDetailArea()
      .find('h4[data-cy="catalogue-item-label"]');
  }

  getModelStatus() {
    return this.getDetailArea()
      .find('mdm-element-status span.badge');
  }

  getModelProperty(name: ModelPropertyIdentifier) {
     return this.getDetailArea()
      .find('div[data-cy="catalogue-item-properties"]')
      .find(`[data-cy="${name}"]`)
  }

  getBranchSelector() {
    return this.getModelProperty('branch')
      .find('select.mdm-branch-selector');
  }

  getCurrentBranch() {
    return this.getBranchSelector()
      .find(':selected')
      .then(elem => {
        cy.log(`Branch name: ${elem.text()}`);
      });
  }

  getOptionButton(option: CatalogueItemDetailOption) {
    const elem = option === 'favourite-toggle' ? 'i' : 'button';
    return this.getDetailArea()
      .find(`${elem}[data-cy="${option}"]`);
  }

  openUserActionsMenu() {
    this.getOptionButton('user-actions-menu').click();
  }

  expandUserActionsSubMenu(option: UserActionsSubMenuOption) {
    this.getUserActionsMenuButton(option)
      .trigger('mouseenter');
  }

  collapseUserActionsSubMenu(option: UserActionsSubMenuOption) {
    this.getUserActionsMenuButton(option)
      .trigger('mouseexit');
  }

  getUserActionsMenuButton(option: UserActionsMenuOption) {  
    return cy.get('div.cdk-overlay-container')
      .find('div.mat-menu-content')
      .find(`button[data-cy="${option}"]`);
  }
}