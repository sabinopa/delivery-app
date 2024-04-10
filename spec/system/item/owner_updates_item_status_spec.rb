require 'rails_helper'

describe 'owner updates item status' do
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
    item = Item.create!(name: 'Omelete com Ervas Finas',
                          description: 'Omelete leve e fofo com uma seleção de ervas finas, queijo de cabra e tomates cereja frescos.',
                          price: '27.00', category_id: categoria.id, menu_id: menu.id, spice_level: 1, additional: 'Queijo de cabra, tomates cereja',
                          vegan: false, vegetarian: true, gluten_free: true)

    visit item_path(item.id)

    expect(page).not_to have_button 'Ativar item'
    expect(page).not_to have_button 'Desativar item'
  end

  it 'turn inactive' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    categoria = Category.create!(name: 'Café da Manhã')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    restaurante = Restaurant.create!(owner: owner, brand_name: 'Delícias Tropicais', corporate_name: 'Delícias Tropicais Gastronomia Ltda',
                                    registration_number: '12.345.678/9012-34', phone_number: '(21) 98765-4321',
                                    email: 'contato@deliciastropicais.com.br', address: 'Avenida Praiana, 123',
                                    neighborhood: 'Praia do Sossego', city: 'Salvador', state: 'BA', zipcode: '41700-000',
                                    description:'Delícias Tropicais oferece uma viagem gastronômica pelas cozinhas praianas,
                                    com um cardápio repleto de frutos do mar frescos e sabores exóticos.', cancelation_policy: 'Cancelamentos devem
                                    ser feitos com até 24 horas de antecedência.', estimated_time: 40, vegan_options: false,
                                    vegetarian_options: false, gluten_free_options: true, status: :active)
                                    restaurante.payment_methods << [pix, credito, debito]
    menu = Menu.create!(restaurant_id: restaurante.id, name: 'Café da Manhã',
                        description: 'Cada prato é cuidadosamente preparado com ingredientes frescos, locais e sazonais.')
    item = Item.create!(name: 'Omelete com Ervas Finas',
                        description: 'Omelete leve e fofo com uma seleção de ervas finas, queijo de cabra e tomates cereja frescos.',
                        price: '27.00', category_id: categoria.id, menu_id: menu.id, spice_level: 1, additional: 'Queijo de cabra, tomates cereja',
                        vegan: false, vegetarian: true, gluten_free: true, status: :active)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Meu Restaurante'
    end
    click_on 'Café da Manhã'
    click_on 'Omelete com Ervas Finas'
    click_on 'Desativar item'

    expect(current_path).to eq item_path(item.id)
    expect(item.reload).to be_inactive
    expect(page).to have_button 'Ativar item'
    expect(page).not_to have_button 'Desativar item'
    expect(page).to have_content 'Omelete com Ervas Finas: Está inativo!'
    expect(page).to have_content 'Item inativo'
  end
end
