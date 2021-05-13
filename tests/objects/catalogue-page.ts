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

import { ElementFinder, $, by } from 'protractor';
import { Navigatable } from './mdm-interfaces';
import { MdmTemplatePage } from './mdm-template-page';

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
}

/**
 * Page object representing the main catalogue page listing the model tree explorer.
 */
export class CataloguePage extends MdmTemplatePage implements Navigatable {
  relativeUrl: string = '/catalogue/dataModel/all';

  getDefaultDetailView(): ElementFinder {
    return $('mdm-data-model-default');
  }

  isDetailViewDisplayingModel(label: string, type: keyof ModelDetailViews): ElementFinder {
    const view = detailViews[type];
    return $(view.parent)
      .$(view.detail)
      .element(by.cssContainingText('span.dataModelDetailsLabel', label));
  }
}