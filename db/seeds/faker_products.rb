# Create Fake Products
(1..354).each do |category|
    10.times do
        Product.create(
            name: Faker::Food.vegetables,
            description: Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 4),
            category_id: category,
            status: rand(0...1)
        )
    end
end