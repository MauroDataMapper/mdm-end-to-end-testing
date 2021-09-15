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

/**
 * Page object helper class to assist with interactions with a `MatTreeNode` Angular component.
 */
 export class MatTreeNodeState {
  constructor(public elem: JQuery<HTMLElement>) { }

  getExpandButton() {
    return this.elem.find('button.mat-icon-button');
  }

  isExpanded() {
    return this.getExpandButton()
      .find('mat-icon')
      .first()
      .hasClass('fa-minus');
  }

  expand() {
    if (!this.isExpanded()) {
      this.getExpandButton().trigger('click');
    }      
  }

  collapse() {
    if (this.isExpanded()) {
      this.getExpandButton().trigger('click');
    }
  }  
}

export class MatTreeObject {
  constructor(public selector: string) { }

  getMatTree() {
    return cy.get(this.selector).get('mat-tree');
  }

  /**
   * Get a tree node that matches a given name/label.
   * @param name The name/label on the tree node to get.
   * @returns A `MatTreeNodeObject` containing the found page element.
   */
   getMatTreeNode(name: string) {    
    return this.getMatTree()
      .get('mat-tree-node')
      .contains('div.mat-tree-node-content', name)
      .parent();
  }

  /**
   * Ensure that each node listed has been expanded. This does not require that the nodes be in hierarchical order.
   * @param names One or more node names/labels.
   */
  ensureExpanded(names: string[]) {
    names.forEach(name => {
      this.getMatTreeNode(name)
        .then(node => new MatTreeNodeState(node).expand());
    })
  }
}