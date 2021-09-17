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

import { apiEndpoint, UserCredentials } from '../helpers/environment.helpers';

export interface AuthenticationResponse {
  authenticatedSession: boolean;
}

export interface ApplicationAdministrationResponse {
  applicationAdministrationSession: boolean;
}

export interface LoginResponse {
  id: string;
  token?: string;
  emailAddress: string;
  firstName: string;
  lastName: string;
  pending?: boolean;
  disabled?: boolean;
  createdBy?: string;
  userRole?: string;
  needsToResetPassword?: boolean;
}

export const login = (credentials: UserCredentials) => cy.request<LoginResponse>(
  'POST',
  apiEndpoint('/authentication/login'),
  {
    username: credentials.email,
    password: credentials.password
  });

export const isAuthenticated = () => cy.request<AuthenticationResponse>(
  apiEndpoint('/session/isAuthenticated'));

export const isApplicationAdministration = () => cy.request<ApplicationAdministrationResponse>(
  apiEndpoint('/session/isApplicationAdministration'));

export const logout = () => cy.request(
  apiEndpoint('/authentication/logout'));