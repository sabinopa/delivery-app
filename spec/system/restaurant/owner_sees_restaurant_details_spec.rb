require 'rails_helper'

describe 'Owner sees restaurant details' do
  it 'from any page through the navigation bar' do
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

    expect(current_path).to eq restaurant_path(restaurante)
    expect(page).to have_content 'Cantina Mediterrânea'
    expect(page).to have_content 'A Cantina Mediterrânea traz os mais frescos ingredientes do mar para a sua mesa, com pratos inspirados na rica culinária mediterrânea.'
    expect(page).to have_content 'Sabores do Mar Mediterrâneo Ltda'
    expect(page).to have_content '98.765.432/0001-11'
    expect(page).to have_content 'Rua das Oliveiras, 5678 - Bairro Italiano, Rio de Janeiro - RJ, 21000-000'
    expect(page).to have_content 'Cancelamentos podem ser feitos até 48 horas antes da reserva.'
    expect(page).to have_content '50 minutos'
    expect(page).to have_content 'Possui opções veganas | vegetarianas.'
    expect(page).to have_content 'Não possui opções sem glúten.'
    expect(page).to have_content 'Pagamentos por: PIX | Cartão de Crédito | Cartão de Débito'
  end

  it 'and returns to home page' do
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
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end