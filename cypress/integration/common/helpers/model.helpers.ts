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

import { CatalogueItemDomainType } from '../api/common-types';

export interface ModelTreeNodeSelection {
  label: string;
  version?: string;
}

/**
 * Determine if a branch name represents the "main" branch of a model.
 *
 * @param name The string to test.
 * @returns True if `name` represents a "main" model branch.
 */
export const isMainBranch = (name: string) => name.indexOf('main') !== -1;

export const isContainerTypeDomain = (domain: CatalogueItemDomainType) => domain === 'Folder';

export const isModelTypeDomain = (domain: CatalogueItemDomainType) =>
  domain === 'DataModel'
  || domain === 'Terminology'
  || domain === 'CodeSet'
  || domain === 'ReferenceDataModel';