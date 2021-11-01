/*
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
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import { apiEndpoint } from '../helpers/environment.helpers';

export const subscribedCatalogueMapWithModel = {
  label: 'Continuous Deployment (admin)',
  url: 'https://modelcatalogue.cs.ox.ac.uk/continuous-deployment',
  apiKey: 'e2ea4cbb-6aaf-4807-a505-514c8fbed54b'
};

export const subscribedCatalogueMapWithoutModel = {
  label: 'Continuous Deployment (public)',
  url: 'https://modelcatalogue.cs.ox.ac.uk/continuous-deployment',
};

/* Model that should be present in 'subscribedCatalogueMapWithModel' catalogue. */
export const subscribedCatalogueModelMap = {
  label: 'E2E Testing - Empty Data Model',
  version: '1.0.0',
  publishedLabel: 'E2E Testing - Empty Data Model 1.0.0'
};

export const createSubscription = (body) => {
  return cy.request(
    'POST',
    apiEndpoint('/subscribedCatalogues'),
    body
  );
};

export const deleteSubscription = (id: string) => {
  return cy.request(
    'DELETE',
    apiEndpoint('/subscribedCatalogues/'+id)
  );
};