require 'rails_helper'

describe 'Owner edits item' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
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
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                       description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                       description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                       price: '29.90', category_id: breakfast.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                       vegan: false, vegetarian: true, gluten_free: false)

    visit edit_item_path(item)

    expect(current_path).to eq new_owner_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    breakfast = Category.create!(name: 'Café da Manhã')
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
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                       description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')
    item = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                       description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                       price: '29.90', category_id: breakfast.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
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
end