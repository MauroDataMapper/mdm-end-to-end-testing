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
}

export const loginAsUser = (name: UserIdentifier) => {
  const credentials = getUserCredentials(name);

  return login(credentials)
    .then(loginResponse => {
      expect(loginResponse.isOkStatusCode, 'Login response is status 200').to.be.true;

      return isApplicationAdministration()
        .then(adminResponse => {
          expect(adminResponse.isOkStatusCode, 'Administration response is status 200').to.be.true;

          const login = loginResponse.body;
          const admin = adminResponse.body;

          const user: UserDetails = {
            id: login.id,
            token: login.token,
            firstName: login.firstName,
            lastName: login.lastName,
            email: login.emailAddress,
            userName: login.emailAddress,
            role: login.userRole?.toLowerCase() ?? '',
            isAdmin: admin.applicationAdministrationSession ?? false,
            needsToResetPassword: login.needsToResetPassword ?? false
          };

          addUserToLocalStorage(user);
          return user;
        })
    })
}

export const isUserLoggedOut = () => {
  isAuthenticated()
    .then(response => expect(response.body.authenticatedSession, 'Authenticated session').to.be.false)
}

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
}