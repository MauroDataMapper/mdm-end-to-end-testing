import {$, $$, ElementFinder} from "protractor";
import {ModalForm} from "./modalForm";


export class LoginForm extends ModalForm {

    constructor() {
        super('form[name="loginForm"]');
    }

    getEmailField(): ElementFinder {
        return this.getField('email');
    }

    getPasswordField(): ElementFinder {
        return this.getField('password');
    }

    getLoginButton(): ElementFinder {
        return this.getButton('Log in');
    }

    getForgotPasswordButton(): ElementFinder {
        return this.getButton('Forgot Password');
    }


}
