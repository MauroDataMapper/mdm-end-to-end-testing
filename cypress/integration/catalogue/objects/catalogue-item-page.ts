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

import { CatalogueItemDomainType, Uuid } from '../../common/api/common-types';
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

export type InlineLabelEditButton = 'save' | 'cancel';

export type UserActionsSubMenuOption =
  'delete-options-menu';

export type DefaultProfileProperty = 
  'aliases'
  | 'description'
  | 'multipicity'
  | 'author'
  | 'organisation'
  | 'terminology'
  | 'url'
  | 'data-type'
  | 'classifications';

export interface MauroCatalogueItem {
  id: Uuid;
  domain: CatalogueItemDomainType;
}

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

  matchesContainer(tagName: string) {
    return this.containerSelector === tagName;
  }

  getDetailArea() {
    return cy.get(this.containerSelector)
      .find(this.detailSelector);
  }

  getMauroData() {
    return cy.get(this.containerSelector)
      .find('[data-cy="catalogue-item-container"]')
      .then(container => {
        const id = container.data('catalogue-item-id');
        const domain = container.data('catalogue-item-domain');

        expect(id, 'data-catalogue-item-id must exist on container').is.not.undefined;
        expect(domain, 'data-catalogue-item-domain must exist on container').is.not.undefined;

        return cy.wrap<MauroCatalogueItem>({
          id,
          domain
        });
      });
  }

  getLabel() {
    return this.getDetailArea()
      .find('h4[data-cy="catalogue-item-label"]');
  }

  getLabelText() {
    return this.getLabel()
      .find('mdm-inline-text-edit')
      .find('span.dataModelDetailsLabel');
  }

  getLabelInlineEditField() {
    return this.getLabel()
      .find('mdm-inline-text-edit')
      .find('input[type="text"]');
  }

  getLabelInlineEditButton(button: InlineLabelEditButton) {
    return this.getLabel()
      .find('mdm-inline-text-edit')
      .find(`button[data-cy="${button}"]`);
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
    return this.getOptionButton('user-actions-menu').click();
  }

  expandUserActionsSubMenu(option: UserActionsSubMenuOption) {
    return this.getUserActionsMenuButton(option)
      .trigger('mouseenter');
  }

  collapseUserActionsSubMenu(option: UserActionsSubMenuOption) {
    return this.getUserActionsMenuButton(option)
      .trigger('mouseexit');
  }

  getUserActionsMenuButton(option: UserActionsMenuOption) {
    return cy.get('div.cdk-overlay-container')
      .find('div.mat-menu-content')
      .find(`button[data-cy="${option}"]`);
  }

  getProfileSelector() {
    return this.getTabGroup()
      .find('mdm-profile-data-view')
      .find('mat-select[data-cy="profile-selector"]');
  }

  getDefaultProfile() {
    return this.getTabGroup()
      .find('mdm-profile-data-view')
      .find('mdm-default-profile');
  }

  getDefaultProfileProperty(property: DefaultProfileProperty) {
    return this.getDefaultProfile()
      .find(`tr[data-cy="${property}"]`)
      .find('td[data-cy="value"]');
  }

  getDefaultProfileEditButton() {
    return this.getTabGroup()
      .find('mdm-profile-data-view')
      .find('button[data-cy="edit-default"]');
  }

  startEditDescription() {
    return this.getDefaultProfileEditButton()
      .click()
      .then(() => cy.get('div.cdk-overlay-container'))
      .find('div.mat-menu-content')
      .find(`button[data-cy="edit-description"]`)
      .click();
  }
}