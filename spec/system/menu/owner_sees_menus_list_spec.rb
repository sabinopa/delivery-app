require 'rails_helper'

describe 'Owner sees every menus' do
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
    breakfast_menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                                  description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')
    lunch_menu = Menu.create!(restaurant_id: restaurante.id, name: 'Almoço',
                              description: 'Um menu diversificado com opções que satisfazem desde os paladares mais simples aos mais exigentes.')
    dinner_menu = Menu.create!(restaurant_id: restaurante.id, name: 'Jantar',
                              description: 'Deliciosas opções para encerrar o dia, desde pratos leves até jantares completos')

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Meu Restaurante'

    expect(page).to have_content 'Menus'
    expect(page).to have_link 'Café da Manhã'
    expect(page).to have_link 'Almoço'
    expect(page).to have_link 'Jantar'
  end

  it 'and return to home page' do
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
    breakfast_menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                                  description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')
    lunch_menu = Menu.create!(restaurant_id: restaurante.id, name: 'Almoço',
                              description: 'Um menu diversificado com opções que satisfazem desde os paladares mais simples aos mais exigentes.')
    dinner_menu = Menu.create!(restaurant_id: restaurante.id, name: 'Jantar',
                              description: 'Deliciosas opções para encerrar o dia, desde pratos leves até jantares completos.')

    login_as(owner, :scope => :owner)
    visit restaurant_path(restaurante)
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
