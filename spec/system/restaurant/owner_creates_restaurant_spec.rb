require 'rails_helper'

describe 'Owner creates restaurant' do
  it 'must be authenticated' do
    visit new_restaurant_path

    expect(current_path).to eq new_owner_session_path
  end

  it 'by being redirected after registration' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    within 'form' do
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar uma conta'
    end

    expect(current_path).to eq new_restaurant_path
  end

  it 'and sees the fields to create a restaurant' do
    PaymentMethod.create!(method: 'PIX')
    PaymentMethod.create!(method: 'Cartão de Crédito')
    PaymentMethod.create!(method: 'Cartão de Débito')
    PaymentMethod.create!(method: 'Dinheiro')
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
    expect(page).to have_content 'Possui opções veganas'
    expect(page).to have_content 'Possui opções vegetarianas'
    expect(page).to have_content 'Possui opções sem glúten'
    expect(page).to have_content 'PIX'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content 'Cartão de Débito'
    expect(page).to have_content 'Dinheiro'
    expect(page).to have_button 'Salvar'
  end

  it 'with incomplete data' do
    owner = Owner.create!(email: 'priscila@email.com', password: '12345678')

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Cadastrar restaurante'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Política de Cancelamento', with: ''
    fill_in 'Tempo Estimado de Entrega', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível cadastrar restaurante.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Bairro não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Tempo Estimado de Entrega não pode ficar em branco'
  end

  it 'successfully' do
    PaymentMethod.create!(method: 'PIX')
    PaymentMethod.create!(method: 'Cartão de Crédito')
    PaymentMethod.create!(method: 'Cartão de Débito')
    PaymentMethod.create!(method: 'Dinheiro')
    owner = Owner.create!(email: 'priscila@email.com', password: '12345678')

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Cadastrar restaurante'
    fill_in 'Nome Fantasia', with: 'Cantina Mediterrânea'
    fill_in 'Razão Social', with: 'Sabores do Mar Mediterrâneo Ltda'
    fill_in 'CNPJ', with: '98.765.432/0001-11'
    fill_in 'Telefone', with: '(11) 99876-5432'
    fill_in 'E-mail', with: 'contato@cantinamediterranea.com.br'
    fill_in 'Endereço', with: 'Rua das Oliveiras, 5678'
    fill_in 'Bairro', with: 'Bairro Italiano'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'CEP', with: '21000-000'
    fill_in 'Descrição', with: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa, com pratos inspirados na rica culinária mediterrânea.'
    fill_in 'Política de Cancelamento', with: 'Cancelamentos podem ser feitos até 48 horas antes da reserva.'
    fill_in 'Tempo Estimado de Entrega', with: '00:50:00'
    check 'Possui opções veganas'
    check 'Possui opções vegetarianas'
    uncheck 'Possui opções sem glúten'
    check 'PIX'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    click_on 'Salvar'

    expect(current_path).to eq restaurant_path(owner.reload.restaurant.id)
    expect(page).to have_content 'Cantina Mediterrânea: Criado com sucesso!'
    expect(page).to have_content 'Telefone: (11) 99876-5432'
    expect(page).to have_content 'E-mail: contato@cantinamediterranea.com.br'
    expect(page).to have_content 'Endereço: Rua das Oliveiras, 5678 - Bairro Italiano, Rio de Janeiro - RJ, 21000-000'
    expect(page).to have_content 'Pagamentos por: PIX | Cartão de Crédito | Cartão de Débito'
    expect(page).to have_content 'Possui opções veganas | vegetarianas.'
    expect(page).to have_content 'Não possui opções sem glúten.'
  end


  it 'already has a restaurant registered' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: '00:50:00', vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    login_as(owner, :scope => :owner)
    visit new_restaurant_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você já possui um restaurante cadastrado.'
  end
end