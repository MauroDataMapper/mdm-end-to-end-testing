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

import { MdmTemplatePage } from '../common/objects/mdm-template-page';
import { ModelTreeView } from './model-tree/model-tree-view';

export interface ModelDetailViewSelectors {
  parent: string;
  detail: string;
}

export interface ModelDetailViews {
  dataModel: ModelDetailViewSelectors;
  terminology: ModelDetailViewSelectors;
  codeSet: ModelDetailViewSelectors;
  referenceDataModel: ModelDetailViewSelectors;
}

const detailViews: ModelDetailViews = {
  dataModel: {
    parent: 'mdm-data-model',
    detail: 'mdm-data-model-detail',
  },
  terminology: {
    parent: 'mdm-terminology',
    detail: 'mdm-terminology-details',
  },
  codeSet: {
    parent: 'mdm-code-set',
    detail: 'mdm-code-set-details',
  },
  referenceDataModel: {
    parent: 'mdm-reference-data',
    detail: 'mdm-reference-data-details'
  }
};

export class CataloguePage extends MdmTemplatePage {
  treeView = new ModelTreeView();

  visit() {
    cy.visit('/#/catalogue/dataModel/all');
  }

  getDefaultCatalogueItemDetailView() {
    return cy.get('mdm-data-model-default');
  }

  isDetailViewDisplayingModel(label: string, type: keyof ModelDetailViews) {
    const view = detailViews[type];
    return cy.get(view.parent)
      .find(view.detail)
      .contains('span.dataModelDetailsLabel', label);
  }
}