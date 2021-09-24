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
import { FolderPage } from './containers/folder-page';
import { ModelTreeView } from './model-tree-view';
import { CodeSetPage } from './models/code-set-page';
import { DataModelPage } from './models/data-model-page';
import { ReferenceDataModelPage } from './models/reference-data-model-page';
import { TerminologyPage } from './models/terminology-page';

export type CatalogueItemTypePageObject =
  DataModelPage
  | TerminologyPage
  | CodeSetPage
  | ReferenceDataModelPage
  | FolderPage;

export interface CatalogueItemTypePageMap {
  dataModel: DataModelPage;
  terminology: TerminologyPage;
  codeSet: CodeSetPage;
  referenceDataModel: ReferenceDataModelPage;
  folder: FolderPage;
}

export class CataloguePage extends MdmTemplatePage {
  treeView = new ModelTreeView();

  catalogueItems: CatalogueItemTypePageMap = {
    dataModel: new DataModelPage(),
    terminology: new TerminologyPage(),
    codeSet: new CodeSetPage(),
    referenceDataModel: new ReferenceDataModelPage(),
    folder: new FolderPage()
  };

  visit() {
    return cy.visit('/#/catalogue/dataModel/all');
  }

  getDefaultCatalogueItemDetailView() {
    return cy.get('mdm-data-model-default');
  }

  getCatalogueItemView(type: keyof CatalogueItemTypePageMap): CatalogueItemTypePageObject {
    return this.catalogueItems[type];
  }

  getCurrentlyLoadedCatalogueItemView() {
    return cy.get('mdm-two-side-panel')
      .find('div.resizableRight')
      .find('div#mdm-ui')
      .children()
      .first()
      .then(view => {
        const viewName: string = view.prop('tagName').toLowerCase();
        const page = Object.values(this.catalogueItems)
          .map(p => p as CatalogueItemTypePageObject)
          .find(p => p.matchesContainer(viewName));

        expect(page, `page with tag name '<${viewName}>'`).is.not.undefined;
        return cy.wrap(page);
      });
  }
}