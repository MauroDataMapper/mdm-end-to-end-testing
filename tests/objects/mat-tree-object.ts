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

/**
 * Page object helper class to assist with interactions with a `MatTreeNode` Angular component.
 */
export class MatTreeNodeObject {
  constructor(public elem: ElementFinder) { }

  async isExpanded(): Promise<boolean> {
    return await this.elem.$('button.mat-icon-button').$('mat-icon.fa-minus').isPresent();
  }

  async expand() {
    if (!await this.isExpanded()) {
      await this.elem.$('button.mat-icon-button').click();
    }
  }

  async collapse() {
    if (await this.isExpanded()) {
      await this.elem.$('button.mat-icon-button').click();
    }
  }

  async click() {
    await this.elem.$('div.mat-tree-node-content').click();
  }
}

/**
 * Page object helper class to assist with interactions with a `MatTree` Angular component.
 */
export class MatTreeObject {
  constructor(public cssSelector: string) { }

  getMatTree(): ElementFinder {
    return $(this.cssSelector).$('mat-tree');
  }

  /**
   * Get a tree node that matches a given name/label.
   * @param name The name/label on the tree node to get.
   * @returns A `MatTreeNodeObject` containing the found page element.
   */
  async getMatTreeNode(name: string): Promise<MatTreeNodeObject> {
    const elem = this.getMatTree()
      .$$('mat-tree-node')
      .filter(async elem => {
        // Find the tree node that contains the label to search for
        const label = elem
          .$('div.mat-tree-node-content')
          .element(by.cssContainingText('span', name));

        return await label.isPresent();
      })
      .first();

    return new MatTreeNodeObject(elem);
  }

  /**
   * Ensure that each node listed has been expanded. This does not require that the nodes be in hierarchical order.
   * @param names One or more node names/labels.
   */
  async ensureExpanded(names: string[]) {
    names.forEach(async name => {
      const node = await this.getMatTreeNode(name);
      await node.expand();
    })
  }
}