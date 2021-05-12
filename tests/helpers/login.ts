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

import { HomePage } from '../features/home/home-page';
import { LoginForm } from '../features/login/login-form';
import { navigateTo } from './navigation';

const homePage: HomePage = new HomePage();
const loginForm: LoginForm = new LoginForm();

export interface UserCredentials {
  userName: string;
  password: string;
  role: 'administrator';
}

export interface MauroUsers {
  administrator: UserCredentials;
}

const users: MauroUsers = {
  administrator: {
    userName: 'admin@maurodatamapper.com',
    password: 'password',
    role: 'administrator'
  }
};

/**
 * Login as a user to help setup MDM for further tests.
 * @param user The test user to login as. Identified as one of the keys in `MauroUsers`.
 */
export async function loginUser(user: keyof MauroUsers) {
  const credentials = users[user];

  await navigateTo(homePage);
  
  // If already logged in, ignore
  if (await homePage.getUserProfileImage().isPresent()) {
    return;
  }

  await homePage.getLoginButton().click();
  await loginForm.login(credentials.userName, credentials.password);  
}