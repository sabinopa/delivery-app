require 'rails_helper'

describe 'Owner creates restaurant' do
  it 'from the home page' do
    owner = Owner.create!(email: 'priscila@email.com', password: '12345678')

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Cadastrar restaurante'

    expect(page).to have_content 'Cadastre seu restaurante'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Logradouro'
    expect(page).to have_field 'Número'
    expect(page).to have_field 'Complemento'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Política de cancelamento'
    expect(page).to have_field 'Tempo estimado de entrega'
    expect(page).to have_field 'Métodos de pagamento aceitos'
    expect(page).to have_button 'Salvar'
  end
end