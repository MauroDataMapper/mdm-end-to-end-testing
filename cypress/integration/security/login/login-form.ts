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

import { MdmForm } from '../../common/objects/mdm-form';

export class LoginForm extends MdmForm {
  constructor() {
    super('form[name="loginForm"]');
  }

  getEmailField() {
    return this.getField('email');
  }

  getPasswordField() {
    return this.getField('password');
  }

  getLoginButton() {
    return this.getButton('Log in');
  }

  getForgotPasswordButton() {
    return this.getButton('Forgot Password');
  }

  getAlert() {
    return this.getForm().get('div.alert');
  }

  /**
   * Initiate log in as a user by providing a email/username and password.
   *
   * @param email The email/username to use. Leave undefined if clearing the input.
   * @param password The password to use. Leave undefined if clearing the input.
   */
  login(email?: string, password?: string) {
    if (email) {
      this.getEmailField().type(email);
    }
    else {
      this.getEmailField().clear();
    }

    if (password) {
      this.getPasswordField().type(password);
    }
    else {
      this.getPasswordField().clear();
    }

    this.getLoginButton().click();
  }
}