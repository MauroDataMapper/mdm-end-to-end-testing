import { MdmForm } from '../common/objects/mdm-form';

export class AddSubscribedCatalogueForm extends MdmForm {
    constructor() {
        super('form[name="subscribedCatForm"]');
    }

    getLabelField() {
        return this.getField('name');
    }

    getDescriptionField() {
        return this.getField('description');
    }

    getUrlField() {
        return this.getField('url');
    }

    getApiKeyField() {
        return this.getField('apiKey');
    }

    getRefreshPeriodField() {
        return this.getField('refreshPeriod');
    }

    getAddSubscriptionButton() {
        return this.getButton('Add subscription');
    }
}