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
 * Page object representing any `<form>` element inside an MDM page.
 */
export class MdmForm {

  /**
   * Creates a new `MdmForm`.
   *
   * @param formCss The form CSS selector to use. This is used to locate the `<form>` element and
   * then find further child elements inside, such as inputs or buttons.
   */
  constructor(public formSelector: string) { }

  getForm() {
    return cy.get(this.formSelector);
  }

  getField(fieldName: string) {
    return this.getForm().get('input[name="' + fieldName + '"]');
  }

  getButton(buttonText: string) {
    return this.getForm().contains('button', buttonText);
  }

  getCloseButton() {
    return this.getForm().get('button close-modal');
  }

  getFormFieldValidationErrors() {
    return this.getForm().get('mat-error');
  }

  getMatchingFormFieldValidationError(value: string) {
    return this.getForm().contains('mat-error', value);
  }
}