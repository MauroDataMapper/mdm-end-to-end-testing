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

  getLogoutButtonFromUserProfileMenu() {
    // There appears to be two logout buttons, possibly to cater for responsive screen sizes.
    // Only one is required though
    return this.getUserProfileMenu()
      .get('button#navbar-logout')
      .last();
  }

  getButton(label: string | RegExp) {
    return cy.contains('button', label);
  }

  getMenuButton(label: string | RegExp) {
    return cy.contains('div.mat-menu-content button', label);
  };

  getToastMessage(message: string | RegExp) {
    return cy.contains('div.toast-message', message);
  }

  logoutViaUserProfileMenu() {
    this.getUserProfileName().click();
    this.getLogoutButtonFromUserProfileMenu().click();
  }

  closeOverlayMenu() {
    return cy.get('.cdk-overlay-backdrop').click();
  }
}