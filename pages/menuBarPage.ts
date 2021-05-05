import {$, $$, browser, by, ElementFinder, protractor} from "protractor";

export class MenuBarPage {

    // public userMenu: ElementFinder;

    constructor() {
    }

    getUserMenuItem(optionName: string): ElementFinder {
        const userMenu = $('div.mat-menu-content');
        return userMenu.element(by.cssContainingText('a', optionName));
    }

    getUserNameField(): ElementFinder {
        return $('nav#mdm--navbar-desktop div.mdm--navbar-user div.profile-name');
    }

    async userMenuLogout() {
        await browser.wait(function() {
            return $('div.mat-menu-content').isPresent();
        });
        const userMenu = $('div.mat-menu-content');
        await browser.wait(function() {
            return userMenu.$('button#navbar-logout').isPresent();
        });
        //TODO: This should really be a 'click()' action, but keep getting errors and inconsistency
        await userMenu.$('button#navbar-logout').sendKeys(protractor.Key.ENTER);
    }

    getLoginButton(): ElementFinder {
        return $('.mdm--navbar-user button');
    }

    getActiveMenuLink(): ElementFinder {
        return $('a.nav-item.nav-link.active');
    }

    getMainTextHeader(): ElementFinder {
        return $('h3');
    }

    getMainTextFirstParagraph(): ElementFinder {
        return $$('div.container p').get(0);
    }

}
