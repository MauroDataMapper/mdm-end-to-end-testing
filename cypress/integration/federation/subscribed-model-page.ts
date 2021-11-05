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

import { CatalogueItemPage } from '../catalogue/objects/catalogue-item-page';

export class SubscribedModelPage extends CatalogueItemPage {
    constructor() {
        super('mdm-federated-data-model-main', 'mdm-federated-data-model-detail');
    }

    getFolderSearchInput() {
        return cy.get('mdm-new-federated-subscription-modal input');
    }

    getSubscriptionModalFolder(name: string) {
        return cy.contains('mdm-new-federated-subscription-modal mat-tree-node div.mat-tree-node-content', name);
    }

    getSubscriptionModalButton(text: string) {
        return cy.contains('mdm-new-federated-subscription-modal button', text);
    }
}