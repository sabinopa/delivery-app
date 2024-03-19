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
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Política de Cancelamento'
    expect(page).to have_field 'Tempo Estimado de Entrega'
    expect(page).to have_content 'Métodos de pagamentos aceitos'
    expect(page).to have_content 'PIX'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content 'Cartão de Débito'
    expect(page).to have_content 'Dinheiro'
    expect(page).to have_content 'Não Aceita'
    expect(page).to have_content 'Aceita'
    expect(page).to have_button 'Salvar'
  end
end