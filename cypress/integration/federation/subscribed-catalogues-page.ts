import { MdmTemplatePage } from '../common/objects/mdm-template-page';

export class SubscribedCataloguePage extends MdmTemplatePage {
    visit() {
        return cy.visit('/#/admin/subscribedCatalogues');
    }

    getAddButton() {
        return cy.get('div#addContent button')
    }
}