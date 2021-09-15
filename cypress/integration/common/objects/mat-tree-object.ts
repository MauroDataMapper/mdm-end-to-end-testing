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
 * Wrapper object around interactions with a `mat-tree` in the UI.
 */
export class MatTreeObject {
  constructor(public selector: string) { }

  /**
   * Gets the actual DOM element representing the `mat-tree`.
   */
  getTree() {
    return cy.get(this.selector).get('mat-tree');
  }

  /**
   * Get a tree node that matches a given name/label.
   * @param name The name/label on the tree node to get.
   * @param version Optional version or branch name to filter on.
   * @returns The chained command containing the located tree node DOM element.
   */
  getTreeNode(name: string, version?: string) {
    let command = this.getTree()
        .get('mat-tree-node')
        .find('div.mat-tree-node-content')
        .filter(`:contains("${name}")`)

    if (version) {
      command = command.filter(`:contains("${version}")`);
    }

    return command.parent();    
  }

  isTreeNodeExpanded(name: string) {
    return this.getTreeNodeExpander(name)
      .find('mat-icon')
      .first()
      .then(icon => icon.hasClass('fa-minus'));
  }

  expandTreeNode(name: string) {
    this
      .isTreeNodeExpanded(name)
      .then(expanded => {
        if (!expanded) {
          this.getTreeNodeExpander(name).click();
        }
      });
  }

  collapseTreeNode(name: string) {
    this
      .isTreeNodeExpanded(name)
      .then(expanded => {
        if (expanded) {
          this.getTreeNodeExpander(name).click();
        }
      });
  }

  /**
   * Ensure that each node listed has been expanded. This does not require that the nodes be in hierarchical order.
   * @param names One or more node names/labels.
   */
  ensureExpanded(names: string[]) {
    names.forEach(name => this.expandTreeNode(name));
  }

  private getTreeNodeExpander(name: string) {
    return this.getTreeNode(name).find('button.mat-icon-button');
  }
}