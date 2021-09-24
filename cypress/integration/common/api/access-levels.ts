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

import { apiEndpoint } from '../helpers/environment.helpers';
import { apiDomainTypeMap, CatalogueItemDomainType, Uuid } from './common-types';

export const makeCatalogueItemPubliclyReadable = (domain: CatalogueItemDomainType, id: Uuid, enable: boolean) => cy.request(
  enable? 'PUT' : 'DELETE',
  apiEndpoint(`/${apiDomainTypeMap.get(domain)}/${id}/readByEveryone`),
  { });