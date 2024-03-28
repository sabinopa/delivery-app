require 'rails_helper'

describe 'Owner sees items lists' do
  it 'in menus page' do
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
    panqueca = Item.create!(name: 'Panquecas de Blueberry com Mel Orgânico',
                            description: 'Deliciosas panquecas de blueberry servidas com mel orgânico e uma seleção de frutas frescas.',
                            price: '29.90', category_id: categoria.id, menu_id: menu.id, spice_level: 0, additional: 'Frutas frescas - 3.00',
                            vegan: false, vegetarian: true, gluten_free: false)
    acai = Item.create!(name: 'Açaí Bowl Vegano',
                         description: 'Tigela de açaí na base de banana com granola caseira, sementes de chia, coco ralado e frutas da estação.',
                         price: '32.50', category_id: categoria.id, menu_id: menu.id, spice_level: 0, additional: 'Granola caseira, sementes de chia - 10.00',
                         vegan: true, vegetarian: true, gluten_free: true)
    omelete = Item.create!(name: 'Omelete com Ervas Finas',
                          description: 'Omelete leve e fofo com uma seleção de ervas finas, queijo de cabra e tomates cereja frescos.',
                          price: '27.00', category_id: categoria.id, menu_id: menu.id, spice_level: 1, additional: 'Queijo de cabra, tomates cereja',
                          vegan: false, vegetarian: true, gluten_free: true)

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Meu Restaurante'
    click_on 'Café da Manhã'

    expect(page).to have_content 'Itens:'
    expect(page).to have_link 'Panquecas de Blueberry com Mel Orgânico'
    expect(page).to have_link 'Açaí Bowl Vegano'
    expect(page).to have_link 'Omelete com Ervas Finas'
  end
end