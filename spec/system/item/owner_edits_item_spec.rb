require 'rails_helper'

describe 'Owner edits item' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    categoria = Category.create!(name: 'Café da Manhã')
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
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                          description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                          price: '29.90', category_id: categoria.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                          vegan: false, vegetarian: true, gluten_free: false)
    visit edit_item_path(item)

    expect(current_path).to eq new_owner_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    categoria = Category.create!(name: 'Café da Manhã')
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
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                        description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                        price: '29.90', category_id: categoria.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                        vegan: false, vegetarian: true, gluten_free: false)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Meu Restaurante'
    end
    click_on 'Café da Manhã'
    click_on 'Panquecas de Blueberry com Mel Orgânico'
    click_on 'Editar'

    expect(current_path).to eq edit_item_path(item)
  end

  it 'from item page details' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    categoria = Category.create!(name: 'Café da Manhã')
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
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                        description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                        price: '29.90', category_id: categoria.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                        vegan: false, vegetarian: true, gluten_free: false)
    login_as(owner, :scope => :owner)
    visit item_path(item)
    click_on 'Editar'

    expect(current_path).to eq edit_item_path(item)
  end

  it 'successfully' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
    brunch = Category.create!(name: 'Brunch')
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
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                        description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                        price: '29.90', category_id: breakfast.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                        vegan: false, vegetarian: true, gluten_free: false)

    login_as(owner, :scope => :owner)
    visit edit_item_path(item.id)

    fill_in 'Nome', with: 'Panquecas de Morango e Banana'
    fill_in 'Descrição', with: 'Deliciosas panquecas de morando e banana servidas com aveia.'
    fill_in 'Preço', with: '27.80'
    select 'Brunch', from: 'item[category_id]'
    fill_in 'Adicionais', with: 'Blueberry - 4.00'
    check 'Vegano'
    click_on 'Salvar'

    expect(current_path).to eq item_path(item)
    expect(page).to have_content 'Panquecas de Morango e Banana: Atualizado com sucesso!'
    expect(page).to have_content 'Panquecas de Morango e Banana'
    expect(page).to have_content 'Brunch'
    expect(page).to have_content 'Deliciosas panquecas de morando e banana servidas com aveia.'
    expect(page).to have_content 'Adicionais: Blueberry - 4.00'
    expect(page).to have_content 'Opção: vegano | vegetariano'
  end

  it 'with incomplete data' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
    brunch = Category.create!(name: 'Brunch')
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
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                        description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                        price: '29.90', category_id: breakfast.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                        vegan: false, vegetarian: true, gluten_free: false)

    login_as(owner, :scope => :owner)
    visit edit_item_path(item.id)

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Salvar'

    expect(current_path).to eq item_path(item)
    expect(page).to have_content 'Não foi possível atualizar os dados do item.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Preço não pode ficar em branco'
  end

  it 'has to be the owner' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
    dessert = Category.create!(name: 'Sobremesa')
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
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                        description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                        price: '29.90', category_id: breakfast.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                        vegan: false, vegetarian: true, gluten_free: false)
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
    item_2 = Item.create!(name: 'Açaí Bowl Vegano',
                          description: 'Tigela de açaí na base de banana com granola caseira, sementes de chia, coco ralado e frutas da estação.',
                          price: '32.50', category_id: dessert.id, menu_id: menu_2.id, spice_level: 0, additional: 'Granola caseira, sementes de chia - 10.00',
                          vegan: true, vegetarian: true, gluten_free: true)

    login_as(priscila, :scope => :owner)
    visit edit_item_path(item_2.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário do restaurante pode editar itens.'
  end
end