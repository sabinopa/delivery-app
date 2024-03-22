require 'rails_helper'

describe 'Owner edits restaurant' do
  it 'must be authenticated' do
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
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]

    visit edit_restaurant_path(restaurante.id)

    expect(current_path).to eq new_owner_session_path
  end

  it 'from home page' do
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
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Meu Restaurante'
    end
    click_on 'Editar'

    expect(current_path).to eq edit_restaurant_path(restaurante.id)
  end

  it 'from restaurant page details' do
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
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]

    login_as(owner, :scope => :owner)
    visit restaurant_path(restaurante.id)
    click_on 'Editar'

    expect(current_path).to eq edit_restaurant_path(restaurante.id)
  end

  it 'successfully' do
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
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]

    login_as(owner, :scope => :owner)
    visit restaurant_path(restaurante.id)
    click_on 'Editar'

    fill_in 'Nome Fantasia', with: 'Delícias Tropicais'
    fill_in 'Razão Social', with: 'Delícias Tropicais Gastronomia Ltda'
    fill_in 'CNPJ', with: '12.345.678/9012-34'
    fill_in 'Telefone', with: '(21) 98765-4321'
    fill_in 'E-mail', with: 'contato@deliciastropicais.com.br'
    fill_in 'Endereço', with: 'Avenida Praiana, 123'
    fill_in 'Bairro', with: 'Praia do Sossego'
    fill_in 'Cidade', with: 'Salvador'
    fill_in 'Estado', with: 'BA'
    fill_in 'CEP', with: '41700-000'
    fill_in 'Descrição', with: 'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas, com um cardápio repleto de frutos do mar frescos e sabores exóticos.'
    fill_in 'Política de Cancelamento', with: 'Cancelamentos devem ser feitos com até 24 horas de antecedência.'
    fill_in 'Tempo Estimado de Entrega', with: '40'
    uncheck 'Possui opções veganas'
    uncheck 'Possui opções vegetarianas'
    check 'Possui opções sem glúten'
    uncheck 'PIX'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    click_on 'Salvar'

    expect(current_path).to eq restaurant_path(owner.reload.restaurant.id)
    expect(page).to have_content 'Delícias Tropicais: Atualizado com sucesso!'
    expect(page).to have_content 'Telefone: (21) 98765-4321'
    expect(page).to have_content 'E-mail: contato@deliciastropicais.com.br'
    expect(page).to have_content 'Endereço: Avenida Praiana, 123 - Praia do Sossego, Salvador - BA, 41700-000'
    expect(page).to have_content 'Política de Cancelamento: Cancelamentos devem ser feitos com até 24 horas de antecedência.'
    expect(page).to have_content 'Tempo Estimado de Entrega: 40 minutos'
    expect(page).to have_content 'Pagamentos por: Cartão de Crédito | Cartão de Débito'
    expect(page).to have_content 'Possui opções sem glúten.'
  end

  it 'with incomplete data' do
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
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]

    login_as(owner, :scope => :owner)
    visit edit_restaurant_path(restaurante.id)
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

    expect(page).to have_content 'Não foi possível atualizar os dados do restaurante.'
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
  end
end