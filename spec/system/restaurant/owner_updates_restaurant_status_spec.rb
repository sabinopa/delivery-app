require 'rails_helper'

describe 'owner updates restaurant status' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Delícias Tropicais', corporate_name: 'Delícias Tropicais Gastronomia Ltda',
                                      registration_number: '12.345.678/9012-34', phone_number: '(21) 98765-4321',
                                      email: 'contato@deliciastropicais.com.br', address: 'Avenida Praiana, 123',
                                      neighborhood: 'Praia do Sossego', city: 'Salvador', state: 'BA', zipcode: '41700-000',
                                      description:'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas,
                                      com um cardápio repleto de frutos do mar frescos e sabores exóticos.', cancelation_policy: 'Cancelamentos devem
                                      ser feitos com até 24 horas de antecedência.', estimated_time: 40, vegan_options: false,
                                      vegetarian_options: false, gluten_free_options: true, status: :active)
                                      restaurante.payment_methods << [pix, debito]

    visit restaurant_path(restaurante.id)

    expect(page).not_to have_button 'Ativar restaurante'
    expect(page).not_to have_button 'Desativar restaurante'
  end

  it 'turn inactive' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Delícias Tropicais', corporate_name: 'Delícias Tropicais Gastronomia Ltda',
                                      registration_number: '12.345.678/9012-34', phone_number: '(21) 98765-4321',
                                      email: 'contato@deliciastropicais.com.br', address: 'Avenida Praiana, 123',
                                      neighborhood: 'Praia do Sossego', city: 'Salvador', state: 'BA', zipcode: '41700-000',
                                      description:'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas,
                                      com um cardápio repleto de frutos do mar frescos e sabores exóticos.', cancelation_policy: 'Cancelamentos devem
                                      ser feitos com até 24 horas de antecedência.', estimated_time: 40, vegan_options: false,
                                      vegetarian_options: false, gluten_free_options: true, status: :active)
                                      restaurante.payment_methods << [pix, debito]

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Meu Restaurante'
    end
    click_on 'Desativar restaurante'

    expect(current_path).to eq restaurant_path(restaurante.id)
    expect(restaurante.reload).to be_inactive
    expect(page).to have_button 'Ativar restaurante'
    expect(page).not_to have_button 'Desativar restaurante'
    expect(page).to have_content 'Delícias Tropicais: Está inativo!'
    expect(page).to have_content 'Restaurante inativo'
  end

  it 'turn active' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Delícias Tropicais', corporate_name: 'Delícias Tropicais Gastronomia Ltda',
                                      registration_number: '12.345.678/9012-34', phone_number: '(21) 98765-4321',
                                      email: 'contato@deliciastropicais.com.br', address: 'Avenida Praiana, 123',
                                      neighborhood: 'Praia do Sossego', city: 'Salvador', state: 'BA', zipcode: '41700-000',
                                      description:'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas,
                                      com um cardápio repleto de frutos do mar frescos e sabores exóticos.', cancelation_policy: 'Cancelamentos devem
                                      ser feitos com até 24 horas de antecedência.', estimated_time: 40, vegan_options: false,
                                      vegetarian_options: false, gluten_free_options: true, status: :inactive)
                                      restaurante.payment_methods << [pix, debito]

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Meu Restaurante'
    end
    click_on 'Ativar restaurante'

    expect(current_path).to eq restaurant_path(restaurante.id)
    expect(restaurante.reload).to be_active
    expect(page).to have_button 'Desativar restaurante'
    expect(page).to have_content 'Delícias Tropicais: Está ativo!'
    expect(page).to have_content 'Restaurante ativo'
  end

  it 'only of his/her owning' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    priscila = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    pedro = Owner.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
    restaurante = Restaurant.create!(owner: priscila, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    restaurante_2 = Restaurant.create!(owner: pedro, brand_name: 'Delícias Tropicais', corporate_name: 'Delícias Tropicais Gastronomia Ltda',
                                      registration_number: '12.345.678/9012-34', phone_number: '(21) 98765-4321',
                                      email: 'contato@deliciastropicais.com.br', address: 'Avenida Praiana, 123',
                                      neighborhood: 'Praia do Sossego', city: 'Salvador', state: 'BA', zipcode: '41700-000',
                                      description:'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas,
                                      com um cardápio repleto de frutos do mar frescos e sabores exóticos.', cancelation_policy: 'Cancelamentos devem
                                      ser feitos com até 24 horas de antecedência.', estimated_time: 40, vegan_options: false,
                                      vegetarian_options: false, gluten_free_options: true)
                                      restaurante.payment_methods << [pix, debito]

    login_as(priscila, :scope => :owner)
    visit restaurant_path(restaurante_2.id)

    expect(page).not_to have_button 'Ativar restaurante'
    expect(page).not_to have_button 'Desativar restaurante'
  end
end