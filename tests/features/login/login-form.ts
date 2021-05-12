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

import { ElementFinder } from 'protractor';
import { MdmForm } from '../../objects/mdm-form';

/**
 * Page object representing the login form displayed when the user clicks the "Log in"
 * button. This form is used to enter credentials to log in.
 */
export class LoginForm extends MdmForm {
  constructor() {
    super('form[name="loginForm"]');
  }

  getEmailField(): ElementFinder {
    return this.getField('email');
  }

  getPasswordField(): ElementFinder {
    return this.getField('password');
  }

  getLoginButton(): ElementFinder {
    return this.getButton('Log in');
  }

  getForgotPasswordButton(): ElementFinder {
    return this.getButton('Forgot Password');
  }

  /**
   * Initiate log in as a user by providing a email/username and password.
   * @param email The email/username to use. Leave undefined if clearing the input.
   * @param password The password to use. Leave undefined if clearing the input.
   */
  async login(email?: string, password?: string) {
    if (email) {
      await this.getEmailField().sendKeys(email);
    }
    else {
      await this.getEmailField().clear();
    }

    if (password) {
      await this.getPasswordField().sendKeys(password);
    }    
    else {
      await this.getPasswordField().clear();
    }

    await this.getLoginButton().click();
  }
}
