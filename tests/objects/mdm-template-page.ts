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

import { ElementFinder, $, by, browser, protractor } from 'protractor';

/**
 * Page object representing any MDM page which uses the default template layout: Navigation bar, user profile menu.
 */
export class MdmTemplatePage {

  getUserMenuItem(optionName: string): ElementFinder {
    const userMenu = $('div.mat-menu-content');
    return userMenu.element(by.cssContainingText('a', optionName));
  }

  getUserNameField(): ElementFinder {
    return $('nav#mdm--navbar-desktop div.mdm--navbar-user div.profile-name');
  }  

  getLoginButton(): ElementFinder {
    return $('.mdm--navbar-user button');
  }

  getActiveMenuLink(): ElementFinder {
    return $('a.nav-item.nav-link.active');
  }

  getUserProfileImage(): ElementFinder {
    return $('nav#mdm--navbar-desktop div.mdm--navbar-user div.profile-img');
  }

  async logout() {
    await this.getUserNameField().click();
    await browser.wait(function () {
      return $('div.mat-menu-content').isPresent();
    });
    const userMenu = $('div.mat-menu-content');
    await browser.wait(function () {
      return userMenu.$('button#navbar-logout').isPresent();
    });
    //TODO: This should really be a 'click()' action, but keep getting errors and inconsistency
    await userMenu.$('button#navbar-logout').sendKeys(protractor.Key.ENTER);
  }
}