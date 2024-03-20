PaymentMethod.destroy_all
Owner.destroy_all
Restaurant.destroy_all

# Métodos de Pagamento
pix = PaymentMethod.create(method: 'PIX')
credito = PaymentMethod.create(method: 'Cartão de Crédito')
debito = PaymentMethod.create(method: 'Cartão de Débito')
dinheiro = PaymentMethod.create(method: 'Dinheiro')

p "Created #{PaymentMethod.count} payment methods"

# Donos
priscila = Owner.create(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
pedro = Owner.create(name: 'Pedro', lastname: 'Araujo', email: 'pedro@email.com', password: 'senhasenha')
guilherme = Owner.create(name: 'Guilherme', lastname: 'Alvares', email: 'guilherme@email.com', password: 'password')
isabel = Owner.create(name: 'Isabel', lastname: 'Maria', email: 'isabel@lagoaserena.com', password: 'secret123')
livia = Owner.create(name: 'Livia', lastname: 'Alves', email: 'livia@email.com', password: '09876543')

p "Created #{Owner.count} owners"

# Restaurantes
restaurant_one = Restaurant.create(owner_id: priscila.id, brand_name: 'Delícias do Chef', corporate_name: 'Delícias do Chef Gastronomia Ltda',
                                  registration_number: '12.345.678/0001-99',  phone_number: '(11) 98765-4321', email: 'contato@deliciasdochef.com.br',
                                  address: 'Avenida Sabor, 1234', neighborhood: 'Centro Gourmet', city: 'São Paulo', state: 'SP', zipcode: '01000-000',
                                  description: 'O restaurante Delícias do Chef oferece uma experiência única com pratos autorais e um ambiente acolhedor.',
                                  vegan_options: true, vegetarian_options: true, gluten_free_options: false,
                                  estimated_time: '00:40:00', cancelation_policy: 'Cancelamentos devem ser feitos com até 24 horas de antecedência.')
restaurant_one.payment_methods << [pix, credito, debito]

restaurant_two = Restaurant.create(owner_id: pedro.id, brand_name: "Sabor da Terra", corporate_name: "Sabor da Terra Orgânicos Ltda",
                                  registration_number: "11.111.111/0001-11", phone_number: "(11) 1111-1111", email: "contato@sabordaterra.com.br",
                                  address: "Rua das Palmeiras, 100", neighborhood: "Verdejante", city: "EcoCity", state: "SC", zipcode: "11000-000",
                                  vegan_options: false, vegetarian_options: true, gluten_free_options: false,
                                  description: "Comida orgânica e vegetariana com ingredientes frescos direto da fazenda.", estimated_time: "00:45:00",
                                  cancelation_policy: "Cancelamento até 2 dias antes do pedido sem custos.")
restaurant_two.payment_methods << [credito, debito]

restaurant_three = Restaurant.create(owner_id: guilherme.id, brand_name: "Cantina Italiana", corporate_name: "Sabores da Itália Ltda",
                                    registration_number: "22.222.222/0002-22", phone_number: "(22) 2222-2222", email: "contato@cantinaitaliana.com.br",
                                    address: "Avenida Roma, 200", neighborhood: "Italiano", city: "Bella Città", state: "IT", zipcode: "22000-000",
                                    vegan_options: false, vegetarian_options: true, gluten_free_options: false,
                                    description: "Autêntica cozinha italiana com um toque moderno.", estimated_time: "01:00:00",
                                    cancelation_policy: "Cancelamentos gratuitos até 48 horas antes da entrega.")
restaurant_three.payment_methods << [pix, dinheiro]

restaurant_four = Restaurant.create(owner_id: isabel.id, brand_name: "Churrascaria Gaúcha", corporate_name: "Fogo de Chão Carnes Ltda",
                                    registration_number: "33.333.333/0003-33", phone_number: "(33) 3333-3333", email: "contato@churrascariagaucha.com.br",
                                    address: "Rua dos Pampas, 300", neighborhood: "Gaúcho", city: "Porto Alegre", state: "RS", zipcode: "33000-000",
                                    vegan_options: false, vegetarian_options: false, gluten_free_options: false,
                                    description: "O verdadeiro sabor do churrasco gaúcho com carnes selecionadas.", estimated_time: "01:15:00",
                                    cancelation_policy: "Cancelamento sem custos até 3 dias antes da reserva.")
restaurant_four.payment_methods << [pix, debito]


restaurant_five = Restaurant.create(owner_id: livia.id, brand_name: "Temakeria do Sol", corporate_name: "Sol Nascente Temakeria Ltda",
                                    registration_number: "44.444.444/0004-44", phone_number: "(44) 4444-4444", email: "contato@temakeriadosol.com.br",
                                    address: "Praça do Sol, 400", neighborhood: "Nipônico", city: "Sol Nascente", state: "SN", zipcode: "44000-000",
                                    vegan_options: false, vegetarian_options: false, gluten_free_options: false,
                                    description: "Experiência única com o melhor da cozinha japonesa contemporânea.", estimated_time: "00:30:00",
                                    cancelation_policy: "Cancelamentos até 24 horas antes, sem taxas.")
restaurant_five.payment_methods << [pix, debito, credito, dinheiro]

p "Created #{Restaurant.count} restaurants"
p "All done! :)"

