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
