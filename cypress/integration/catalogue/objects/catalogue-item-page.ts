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

export type CatalogueItemPropertyIdentifier =
  'item-type'
  | 'availability'
  | 'authority'
  | 'documentation-version'
  | 'model-version'
  | 'branch'
  | 'last-update';

export type CatalogueItemOptionIdentifier =
  'user-actions-menu'
  | 'user-group-access'
  | 'export-menu'
  | 'search'
  | 'favourite-toggle';

export type CatalogueItemTabIdentifier =
  'Description'
  | 'Schema'
  | 'Elements'
  | 'Types'
  | 'Data'
  | 'Terms'
  | 'Links'
  | 'Context'
  | 'Rules'
  | 'Annotations'
  | 'History';

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

/**
 * Base class for all page views representing the details of a catalogue item.
 */
export class CatalogueItemPage extends MdmTemplatePage {
  /**
   * Creates a new `CatalogueItemPage`.
   *
   * @param containerSelector The DOM selector for the overall view container of the catalogue item.
   * @param detailSelector The DOM selector for the detail section of the catalogue item.
   */
  constructor(
    protected containerSelector: string,
    protected detailSelector: string) {
    super();
  }

  getDetailArea() {
    return cy.get(this.containerSelector)
      .find(this.detailSelector);
  }

  getLabel() {
    return this.getDetailArea()
      .find('h4[data-cy="catalogue-item-label"]');
  }

  getModelProperty(name: CatalogueItemPropertyIdentifier) {
    return this.getDetailArea()
      .find('div[data-cy="catalogue-item-properties"]')
      .find(`[data-cy="${name}"]`);
  }

  getOptionButton(option: CatalogueItemOptionIdentifier) {
    const elem = option === 'favourite-toggle' ? 'i' : 'button';
    return this.getDetailArea()
      .find(`${elem}[data-cy="${option}"]`);
  }

  getTabGroup() {
    return cy.get(this.containerSelector)
      .find('mat-tab-group');
  }

  getTab(name: CatalogueItemTabIdentifier) {
    return this.getTabGroup()
      .contains('div[role="tab"]', name);
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