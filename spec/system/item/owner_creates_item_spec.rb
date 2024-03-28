require 'rails_helper'

describe 'Owner creates item' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')


    visit new_menu_item_path(menu)

    expect(current_path).to eq new_owner_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Meu Restaurante'
    click_on 'Adicionar Item'

    expect(current_path).to eq new_menu_item_path(menu)
  end

  it 'and sees the fields to create an item' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')

    login_as(owner, :scope => :owner)
    visit new_menu_item_path(menu)

    expect(page).to have_content 'Criar novo item para Café da Manhã'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Adicionais'
    expect(page).to have_content 'Categoria'
    expect(page).to have_content 'Nível de Picante'
    expect(page).to have_content 'Vegano'
    expect(page).to have_content 'Vegetariano'
    expect(page).to have_content 'Sem Glúten'
  end

  it 'with incomplete data' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')

    login_as(owner, :scope => :owner)
    visit new_menu_item_path(menu)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Item não cadastrado.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end

  it 'succesfully' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')

    login_as(owner, :scope => :owner)
    visit new_menu_item_path(menu)
    fill_in 'Nome', with: 'Omelete Mediterrâneo'
    fill_in 'Descrição', with: 'Deliciosa combinação de ovos pochê, tomate, cebola e especiarias, servida com pão artesanal.'
    fill_in 'Preço', with: '35,00'
    select 'Café da Manhã', from: 'item[category_id]'
    fill_in 'Adicionais', with: 'Pão sem glúten - R$5,00'
    choose 'spice_level_2'
    check 'Vegetariano'
    check 'Sem Glúten'
    click_on 'Salvar'

    new_item = Item.last
    expect(current_path).to eq item_path(new_item)
    expect(page).to have_content 'Omelete Mediterrâneo: Criado com sucesso!'
    expect(page).to have_content 'Omelete Mediterrâneo'
    expect(page).to have_content 'Café da Manhã'
    expect(page).to have_content 'Deliciosa combinação de ovos pochê, tomate, cebola e especiarias, servida com pão artesanal.'
    expect(page).to have_content 'Adicionais: Pão sem glúten - R$5,00'
    expect(page).to have_content 'Nível de Picante: 2'
    expect(page).to have_content 'Opção: vegetariano | sem glúten'
  end

  it 'has to be the owner' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
    priscila = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: priscila, brand_name: 'Cantina Mediterrânea', corporate_name: 'Sabores do Mar Mediterrâneo Ltda',
                                    registration_number: '98.765.432/0001-11', phone_number: '(11) 99876-5432',
                                    email: 'contato@cantinamediterranea.com.br', address: 'Rua das Oliveiras, 5678',
                                    neighborhood: 'Bairro Italiano', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                                    description: 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa,
                                    com pratos inspirados na rica culinária mediterrânea.', cancelation_policy: 'Cancelamentos podem
                                    ser feitos até 48 horas antes da reserva.', estimated_time: 50, vegan_options: true,
                                    vegetarian_options: true, gluten_free_options: false)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')
    pedro =  Owner.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
    restaurante_2 = Restaurant.create!(owner: pedro, brand_name: 'Delícias Tropicais', corporate_name: 'Delícias Tropicais Gastronomia Ltda',
                                      registration_number: '12.345.678/9012-34', phone_number: '(21) 98765-4321',
                                      email: 'contato@deliciastropicais.com.br', address: 'Avenida Praiana, 123',
                                      neighborhood: 'Praia do Sossego', city: 'Salvador', state: 'BA', zipcode: '41700-000',
                                      description:'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas,
                                      com um cardápio repleto de frutos do mar frescos e sabores exóticos.', cancelation_policy: 'Cancelamentos devem
                                      ser feitos com até 24 horas de antecedência.', estimated_time: 40, vegan_options: false,
                                      vegetarian_options: false, gluten_free_options: true)
                                      restaurante.payment_methods << [pix, debito]
    menu_2 = Menu.create!(restaurant_id: restaurante_2.id, name: 'Jantar',
                          description: 'Massas especiais com ingredientes de alta qualidade.')

    login_as(priscila, :scope => :owner)
    visit new_menu_item_path(menu_2)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário do restaurante pode criar itens.'
  end
end