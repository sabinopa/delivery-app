PaymentMethod.destroy_all
Owner.destroy_all
Restaurant.destroy_all

#Categorias
categoria_entradas = Category.create!(name: 'Entradas')
categoria_principais = Category.create!(name: 'Pratos Principais')
categoria_sobremesas = Category.create!(name: 'Sobremesas')
categoria_bebidas = Category.create!(name: 'Bebidas')
categoria_veganos = Category.create!(name: 'Veganos')
categoria_saladas = Category.create!(name: 'Saladas')

p "Created #{Category.count} categories"

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
delicias_chef = Restaurant.create(owner_id: priscila.id, brand_name: 'Delícias do Chef', corporate_name: 'Delícias do Chef Gastronomia Ltda',
                                  registration_number: '12.345.678/0001-99',  phone_number: '(11) 98765-4321', email: 'contato@deliciasdochef.com.br',
                                  address: 'Avenida Sabor, 1234', neighborhood: 'Centro Gourmet', city: 'São Paulo', state: 'SP', zipcode: '01000-000',
                                  description: 'O restaurante Delícias do Chef oferece uma experiência única com pratos autorais e um ambiente acolhedor.',
                                  vegan_options: true, vegetarian_options: true, gluten_free_options: false,
                                  estimated_time: 40, cancelation_policy: 'Cancelamentos devem ser feitos com até 24 horas de antecedência.')
delicias_chef.payment_methods << [pix, credito, debito]

sabor_terra = Restaurant.create(owner_id: pedro.id, brand_name: "Sabor da Terra", corporate_name: "Sabor da Terra Orgânicos Ltda",
                                  registration_number: "11.111.111/0001-11", phone_number: "(11) 1111-1111", email: "contato@sabordaterra.com.br",
                                  address: "Rua das Palmeiras, 100", neighborhood: "Verdejante", city: "EcoCity", state: "SC", zipcode: "11000-000",
                                  vegan_options: false, vegetarian_options: true, gluten_free_options: false,
                                  description: "Comida orgânica e vegetariana com ingredientes frescos direto da fazenda.", estimated_time: 45,
                                  cancelation_policy: "Cancelamento até 2 dias antes do pedido sem custos.")
sabor_terra.payment_methods << [credito, debito]

cantina_italiana = Restaurant.create(owner_id: guilherme.id, brand_name: "Cantina Italiana", corporate_name: "Sabores da Itália Ltda",
                                    registration_number: "22.222.222/0002-22", phone_number: "(22) 2222-2222", email: "contato@cantinaitaliana.com.br",
                                    address: "Avenida Roma, 200", neighborhood: "Italiano", city: "Bella Città", state: "IT", zipcode: "22000-000",
                                    vegan_options: false, vegetarian_options: true, gluten_free_options: false,
                                    description: "Autêntica cozinha italiana com um toque moderno.", estimated_time: 60,
                                    cancelation_policy: "Cancelamentos gratuitos até 48 horas antes da entrega.")
cantina_italiana.payment_methods << [pix, dinheiro]

gaucha = Restaurant.create(owner_id: isabel.id, brand_name: "Churrascaria Gaúcha", corporate_name: "Fogo de Chão Carnes Ltda",
                                    registration_number: "33.333.333/0003-33", phone_number: "(33) 3333-3333", email: "contato@churrascariagaucha.com.br",
                                    address: "Rua dos Pampas, 300", neighborhood: "Gaúcho", city: "Porto Alegre", state: "RS", zipcode: "33000-000",
                                    vegan_options: false, vegetarian_options: false, gluten_free_options: false,
                                    description: "O verdadeiro sabor do churrasco gaúcho com carnes selecionadas.", estimated_time: 75,
                                    cancelation_policy: "Cancelamento sem custos até 3 dias antes da reserva.")
gaucha.payment_methods << [pix, debito]


temakeria = Restaurant.create(owner_id: livia.id, brand_name: "Temakeria do Sol", corporate_name: "Sol Nascente Temakeria Ltda",
                                    registration_number: "44.444.444/0004-44", phone_number: "(44) 4444-4444", email: "contato@temakeriadosol.com.br",
                                    address: "Praça do Sol, 400", neighborhood: "Nipônico", city: "Sol Nascente", state: "SN", zipcode: "44000-000",
                                    vegan_options: false, vegetarian_options: false, gluten_free_options: false,
                                    description: "Experiência única com o melhor da cozinha japonesa contemporânea.", estimated_time: 30,
                                    cancelation_policy: "Cancelamentos até 24 horas antes, sem taxas.")
temakeria.payment_methods << [pix, debito, credito, dinheiro]

p "Created #{Restaurant.count} restaurants"

# Para o restaurante_one (Delícias do Chef)
executivo = Menu.create(restaurant: delicias_chef, name: 'Menu Executivo', description: 'Pratos rápidos e saborosos para o seu almoço de trabalho.')
desgustação = Menu.create(restaurant: delicias_chef, name: 'Menu Degustação', description: 'Uma seleção especial dos nossos melhores pratos.')

# Para o restaurante_two (Sabor da Terra)
vegetariano = Menu.create(restaurant: sabor_terra, name: 'Menu Vegetariano', description: 'Variedade e sabor em pratos 100% vegetarianos.')
organico = Menu.create(restaurant: sabor_terra, name: 'Menu Orgânico', description: 'Ingredientes orgânicos para uma refeição saudável e natural.')

# Para o restaurante_three (Cantina Italiana)
classico = Menu.create(restaurant: cantina_italiana, name: 'Menu Clássico', description: 'Os clássicos da cozinha italiana com um toque da casa.')
moderno = Menu.create(restaurant: cantina_italiana, name: 'Menu Moderno', description: 'Inovações e pratos contemporâneos da Itália.')

# Para o restaurante_four (Churrascaria Gaúcha)
tradicional = Menu.create(restaurant: gaucha, name: 'Menu Tradicional', description: 'O melhor do churrasco gaúcho com cortes tradicionais.')
premium = Menu.create(restaurant: gaucha, name: 'Menu Premium', description: 'Seleção premium de carnes para os verdadeiros apreciadores.')

# Para o restaurante_five (Temakeria do Sol)
temaki = Menu.create(restaurant: temakeria, name: 'Menu Temaki', description: 'Diversas opções de temakis, do tradicional ao inovador.')
sushi = Menu.create(restaurant: temakeria, name: 'Menu Sushi', description: 'Seleção especial de sushis preparados na hora.')

puts "Created #{Menu.count} menus"

# Criando itens para o restaurante_one
salada_caesar = Item.create(menu: executivo, name: "Salada Caesar", description: "Clássica salada Caesar com frango grelhado, croutons e molho especial.", price: "25.90", category: categoria_principais, vegan: false, vegetarian: false, gluten_free: false)
pudim_leite = Item.create(menu: executivo, name: "Pudim de Leite", description: "Sobremesa tradicional, suave e cremosa.", price: "15.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

carpaccio = Item.create(menu: desgustação, name: "Carpaccio de Beterraba", description: "Beterraba fatiada finamente, servida com molho de mostarda e mel.", price: "22.90", category: categoria_entradas, vegan: true, vegetarian: true, gluten_free: true)
tiramisu = Item.create(menu: desgustação, name: "Tiramisu", description: "Sobremesa italiana clássica com camadas de creme mascarpone e café.", price: "18.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

# Criando itens para o restaurante_two
quiche = Item.create(menu: vegetariano, name: "Quiche Vegetariano", description: "Quiche leve com uma seleção de legumes frescos.", price: "20.90", category: categoria_principais, vegan: false, vegetarian: true, gluten_free: false)
sorvete_coco = Item.create(menu: vegetariano, name: "Sorvete de Coco", description: "Sorvete artesanal de coco com pedaços de coco tostado.", price: "12.90", category: categoria_sobremesas, vegan: true, vegetarian: true, gluten_free: true)

bowl = Item.create(menu: organico, name: "Bowl Orgânico", description: "Mix de grãos, legumes orgânicos e proteína vegetal.", price: "28.90", category: categoria_saladas, vegan: true, vegetarian: true, gluten_free: true)
frutas = Item.create(menu: organico, name: "Frutas da Estação", description: "Seleção de frutas frescas da estação.", price: "10.90", category: categoria_veganos, vegan: true, vegetarian: true, gluten_free: true)

# Para o restaurante_three (Cantina Italiana)
risoto = Item.create(menu: classico, name: "Risotto al Funghi", description: "Cremoso risotto com seleção de cogumelos silvestres e queijo parmesão.", price: "32.90", category: categoria_principais, vegan: false, vegetarian: true, gluten_free: true)
gelato = Item.create(menu: classico, name: "Gelato Italiano", description: "Autêntico gelato italiano. Escolha entre chocolate, baunilha ou morango.", price: "12.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

polenta = Item.create(menu: moderno, name: "Polenta com Ragù de Cogumelos", description: "Polenta macia com um rico ragù de cogumelos porcini.", price: "29.90", category: categoria_principais, vegan: true, vegetarian: true, gluten_free: true)
panna_cotta = Item.create(menu: moderno, name: "Panna Cotta com Frutas Vermelhas", description: "Suave panna cotta acompanhada de uma calda fresca de frutas vermelhas.", price: "15.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

# Para o restaurante_four (Churrascaria Gaúcha)
picanha = Item.create(menu: tradicional, name: "Picanha no Sal Grosso", description: "Tradicional picanha grelhada com sal grosso, servida com farofa e vinagrete.", price: "45.90", category: categoria_principais, vegan: false, vegetarian: false, gluten_free: true)
quindim = Item.create(menu: tradicional, name: "Quindim", description: "Clássico quindim com coco ralado e uma textura inigualável.", price: "10.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

costela = Item.create(menu: premium, name: "Costela Fogo de Chão", description: "Costela assada lentamente em fogo de chão, desmanchando de tão macia.", price: "59.90", category: categoria_principais, vegan: false, vegetarian: false, gluten_free: true)
pudim = Item.create(menu: premium, name: "Pudim de Leite da Casa", description: "Delicioso pudim de leite com calda de caramelo, receita tradicional da casa.", price: "14.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

# Para o restaurante_five (Temakeria do Sol)
temaki_salmao = Item.create(menu: temaki, name: "Temaki de Salmão", description: "Temaki de salmão fresco, arroz, cebolinha e cream cheese.", price: "18.90", category: categoria_principais, vegan: false, vegetarian: false, gluten_free: false)
mochi = Item.create(menu: temaki, name: "Mochi", description: "Doces mochis japoneses, sabores variados.", price: "12.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

shushi_veg = Item.create(menu: sushi, name: "Sushi Vegano", description: "Variedade de sushis veganos, com ingredientes frescos e inovadores.", price: "22.90", category: categoria_principais, vegan: true, vegetarian: true, gluten_free: false)
dorayaki = Item.create(menu: sushi, name: "Dorayaki", description: "Tradicional doce japonês, recheado com pasta doce de feijão azuki.", price: "9.90", category: categoria_sobremesas, vegan: false, vegetarian: true, gluten_free: false)

p "Created #{Item.count} items"

p "All done! :)"
