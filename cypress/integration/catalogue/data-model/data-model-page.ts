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

import { MdmTemplatePage } from '../../common/objects/mdm-template-page';

export type ModelPropertyIdentifier = 
  'item-type'
  | 'availability'
  | 'authority'
  | 'documentation-version'
  | 'model-version'
  | 'branch';

export class DataModelPage extends MdmTemplatePage {
  getDetailArea() {
    return cy.get('mdm-data-model')
      .find('mdm-data-model-detail');
  }

  getLabel() {
    return this.getDetailArea()
      .find('h4[data-cy="catalogue-item-label"]');
  }

  getModelStatus() {
    return this.getDetailArea()
      .find('mdm-element-status span.badge');
  }

  getModelProperty(name: ModelPropertyIdentifier) {
     return this.getDetailArea()
      .find('div[data-cy="model-properties"]')
      .find(`[data-cy="${name}"]`)
  }
}