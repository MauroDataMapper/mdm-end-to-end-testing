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

import { MatDialog } from '../../../common/objects/mat-dialog';

export type UserAccessOption =
  'shareReadWithEveryone'
  | 'shareReadWithAuthenticated';

export class UserGroupAccessDialog extends MatDialog {
  constructor() {
    super('mdm-security-modal');
  }

  getUserAccessOption(option: UserAccessOption) {
    return this.getContainer()
      .find(`mat-checkbox[name="${option}"]`);
  }

  getUserAccessOptionRawInput(option: UserAccessOption) {
    return this.getUserAccessOption(option)
      .find('input[type="checkbox"][name="shareReadWithEveryone"]');
  }
}