require 'rails_helper'

describe 'Visitor views homepage' do
    it 'and sees the apps name' do
        visit root_path
        expect(page).to have_content 'Delivery-APP'
    end
end
