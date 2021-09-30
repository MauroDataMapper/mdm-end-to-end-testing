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

import {UserActionsMenuOption} from "../../catalogue/objects/catalogue-item-page";

export type ProfileMenuActionsOption = 'menu-profile'
    | 'menu-preferences'
    | 'menu-change-password'
    | 'menu-api-keys'
    | 'menu-admin-dashboard'
    | 'menu-admin-model-management'
    | 'menu-admin-subscribed-catalogues'
    | 'menu-admin-emails'
    | 'menu-admin-manage-users'
    | 'menu-admin-pending-users'
    | 'menu-admin-manage-groups'
    | 'menu-admin-openidconnect'
    | 'menu-admin-configuration'
    | 'menu-logout';

/**
 * Base class for all Mauro pages following the standard template (logo, navbar, login/user profile etc).
 */
export class MdmTemplatePage {
  getActiveMenuLink() {
    return cy.get('a.nav-item.nav-link.active');
  }

  getLogInButton() {
    return cy.get('.mdm--navbar-user button').should('have.text', 'Log in');
  }

  getUserProfileImage() {
    return cy.get('nav#mdm--navbar-desktop div.mdm--navbar-user div.profile-img');
  }

  getUserProfileName() {
    return cy.get('nav#mdm--navbar-desktop div.mdm--navbar-user div.profile-name');
  }

  getUserProfileMenu() {
    return cy.get('div.mat-menu-content');
  }

  getProfileMenuButton(option: ProfileMenuActionsOption) {
    return cy.get('div.cdk-overlay-container')
        .find('div.mat-menu-content')
        .find(`[data-cy="${option}"]`);
  }

  changePasswordFromUserProfileMenu() {
    this.getUserProfileName().click();
    //this.getProfileMenuButton('menu-change-password').click();
  }

  logoutViaUserProfileMenu() {
    this.getUserProfileName().click();
    this.getProfileMenuButton('menu-logout').click();
  }

  closeOverlayMenu() {
    return cy.get('.cdk-overlay-backdrop').click();
  }
}
