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

import { CatalogueItemPage } from './catalogue-item-page';

/**
 * Base class for all page views representing the details of a model catalogue item, such as a Data Model.
 */
export class ModelTypePage extends CatalogueItemPage {
  constructor(
    containerSelector: string, 
    detailSelector: string) {
    super(containerSelector, detailSelector);
  }

  getModelStatus() {
    return this.getDetailArea()
      .find('mdm-element-status span.badge');
  }

  getBranchSelector() {
    return this.getModelProperty('branch')
      .find('select.mdm-branch-selector');
  }

  getCurrentBranch() {
    return this.getBranchSelector()
      .find(':selected')
      .then(elem => {
        cy.log(`Branch name: ${elem.text()}`);
      });
  }
}