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

import { isApplicationAdministration, isAuthenticated, login, logout } from '../api/security.api';
import { getUserCredentials, UserIdentifier } from './environment.helpers';

const addUserToLocalStorage = (user: UserDetails) => {
  // Keep username for 100 days
  const expireDate = new Date();
  expireDate.setDate(expireDate.getDate() + 1);
  localStorage.setItem('userId', user.id);
  localStorage.setItem('token', user.token);
  localStorage.setItem('firstName', user.firstName);
  localStorage.setItem('lastName', user.lastName);
  localStorage.setItem(
    'username',
    JSON.stringify({ username: user.userName, expiry: expireDate })
  );
  localStorage.setItem('userId', user.id);
  localStorage.setItem('isAdmin', String(user.isAdmin));

  localStorage.setItem(
    'email',
    JSON.stringify({ email: user.email, expiry: expireDate })
  );
  localStorage.setItem('role', user.role);
  localStorage.setItem('needsToResetPassword', String(user.needsToResetPassword));
};

export interface UserDetails {
  id: string;
  token?: string;
  firstName: string;
  lastName: string;
  userName: string;
  email: string;
  role?: string;
  isAdmin?: boolean;
  needsToResetPassword?: boolean;
}

export const ensureUserIsLoggedOut = () => {
  isAuthenticated()
    .then(response => {
      if (!response.body.authenticatedSession) {
        return;
      }

      logout().its('status').should('equal', 204);
    });
};

/**
 * Login as a user via the Mauro API.
 *
 * @param name The name of the user to login as.
 * @returns The {@link UserDetails} of the authenticated user.
 *
 * This function directly authenticates a user using the Mauro API instead of clicking through the UI to do
 * the same action to speed up tests - most tests will by default need to have an authenticated user in an
 * initial state. See https://docs.cypress.io/guides/getting-started/testing-your-app#Logging-in
 *
 * This function replicates how mdm-ui would sign in a user, by also storing state in local storage. This is
 * required so that, after navigating to other pages in the application, the UI knows that there is a user
 * signed in.
 */
export const loginAsUser = (name: UserIdentifier) => {
  const credentials = getUserCredentials(name);

  return login(credentials)
    .then(loginResponse => {
      expect(loginResponse.isOkStatusCode, 'Login response is status 200').to.be.true;

      return isApplicationAdministration()
        .then(adminResponse => {
          expect(adminResponse.isOkStatusCode, 'Administration response is status 200').to.be.true;

          const loginBody = loginResponse.body;
          const adminBody = adminResponse.body;

          const user: UserDetails = {
            id: loginBody.id,
            token: loginBody.token,
            firstName: loginBody.firstName,
            lastName: loginBody.lastName,
            email: loginBody.emailAddress,
            userName: loginBody.emailAddress,
            role: loginBody.userRole?.toLowerCase() ?? '',
            isAdmin: adminBody.applicationAdministrationSession ?? false,
            needsToResetPassword: loginBody.needsToResetPassword ?? false
          };

          addUserToLocalStorage(user);
          return user;
        });
    });
};

export const isUserLoggedOut = () => {
  isAuthenticated()
    .then(response => expect(response.body.authenticatedSession, 'Authenticated session').to.be.false);
};