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

import {$, by, ElementFinder} from "protractor";

export class ModalForm {

    public formCss: string;

    constructor(formCss: string) {
        this.formCss = formCss
    }

    getField(fieldName: string): ElementFinder  {
        return this.getForm().$('input[name="' + fieldName + '"]')
    }

    getForm(): ElementFinder {
        return $(this.formCss);
    }

    getButton(buttonText: string): ElementFinder {
        return this.getForm().element(by.cssContainingText('button', buttonText));
    }

    getCloseButton(): ElementFinder {
        return this.getForm().$('button close-modal')
    }
}
