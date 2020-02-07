# SellerPlan.create(
#     name: "Basic",
#     stripe_id: "Basic-Monthly",
#     amount: 19900,
#     interval: "month",
#     num_of_products: 50,
#     num_of_locations: 5,
#     num_of_sub_accounts: 5,
#     analytics: "Basic",
#     pause: false
# )
#
# SellerPlan.create(
#     name: "Advanced",
#     stripe_id: "Advanced-Monthly",
#     amount: 29900,
#     interval: "month",
#     num_of_products: 200,
#     num_of_locations: 15,
#     num_of_sub_accounts: 15,
#     analytics: "Advanced",
#     pause: false
# )
#
# ### Generate 50 random products in 3 different root categories
# vege = Category.create(name: "Vegetables", pause: false)
# child = Category.create(name: "Brassica oleracea", parent: vege, type_of_products: "Leaves, axillary buds, stems, flower heads", pause: false)
# child = Category.create(name: "Brassica rapa", parent: vege, type_of_products: "Root, leaves", pause: false)
# child = Category.create(name: "Raphanus sativus", parent: vege, type_of_products: "Root, leaves, seed pods, seed oil, sprouting", pause: false)
# child = Category.create(name: "Beta vulgaris", parent: vege, type_of_products: "Root, leaves", pause: false)
# child = Category.create(name: "Lactuca sativa", parent: vege, type_of_products: "Leaves, stems, seed oil", pause: false)
# child2 = Category.create(name: "Dioscorea spp.", parent: child, type_of_products: "Tubers", pause: false)
# child2 = Category.create(name: "Ipomoea batatas", parent: child, type_of_products: "Tubers, leaves, shoots", pause: false)
# child2 = Category.create(name: "Manihot esculenta", parent: child, type_of_products: "Tubers", pause: false)
#
#
# fruit = Category.create(name: "Fruits", pause: false)
# child = Category.create(name: "Apples", parent: fruit, type_of_products: "Apples", pause: false)
# child = Category.create(name: "Citrus", parent: fruit, type_of_products: "Oranges, grapefruits, mandarins and limes", pause: false)
# child2 = Category.create(name: "Stone fruit", parent: child, type_of_products: "Nectarines, apricots, peaches and plums", pause: false)
# child = Category.create(name: "Tropical and exotic", parent: fruit, type_of_products: "Bananas and mangoes", pause: false)
# child2 = Category.create(name: "Berries", parent: child, type_of_products: "Strawberries, raspberries, blueberries, kiwifruit and passionfruit", pause: false)
# child = Category.create(name: "Melons", parent: fruit, type_of_products: "Watermelons, rockmelons and honeydew melons", pause: false)
# child2 = Category.create(name: "Tomatoes", parent: child, type_of_products: "Tomatoes", pause: false)
#
#
# spices = Category.create(name: "Spices", pause: false)
# child = Category.create(name: "Bitter", parent: spices, type_of_products: "Ajwain, Bay Leaf, Celery, Clove, Cumin Seed, Epazote, Fenugreek Seeds, Horseradish, Juniper, Lavender, Mace, Marjoram, Oregano, Summer Savory, Sichuan Peppercorns, Star Anise, Turmeric, Thyme", pause: false)
# child = Category.create(name: "Cooling", parent: spices, type_of_products: "Spearmint, Dill, Anise,  Fennel, Sweet Basil", pause: false)
# child = Category.create(name: "Earthy", parent: spices, type_of_products: "Achiote, Cumin, Saffron", pause: false)
# child = Category.create(name: "Floral", parent: spices, type_of_products: "Coriander, Lemongrass, Rose Petals, Saffron, Sweet Basil, Thyme, Lavender", pause: false)
# child = Category.create(name: "Fruity", parent: spices, type_of_products: "Anise, Fennel, Nigella, Summer Savory, Star Anise, Tamarind", pause: false)
# child = Category.create(name: "Herbaceous", parent: spices, type_of_products: "Dill Weed, Lavender, Oregano, Parsley, Rosemary, Sage, Summer Savory, Tarragon, Thyme", pause: false)
# child = Category.create(name: "Hot", parent: spices, type_of_products: "Black Pepper, Chiles, Horseradish, Mustard, Wasabi, White Pepper", pause: false)
#
#
#
#
# 50.times do
#   Product.create(
#     name: Faker::Food.unique.vegetables,
#     category_id: rand(1...8),
#     barcode: Faker::Number.number(digits: 6),
#     status: rand(0...1)
#   )
# end
#
# 50.times do
#   Product.create(
#     name: Faker::Food.unique.fruits,
#     category_id: rand(9...16),
#     barcode: Faker::Number.number(digits: 6),
#     status: rand(0...1)
#   )
# end
#
# 50.times do
#   Product.create(
#     name: Faker::Food.unique.spices,
#     category_id: rand(17...24),
#     barcode: Faker::Number.number(digits: 6),
#     status: rand(0...1)
#   )
# end
