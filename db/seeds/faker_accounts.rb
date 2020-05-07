# Create Fake Users + Seller account to each
(1..100).each do |user|
    u = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "123456"
    )
    s = Seller.create(
        owner_id: u.id,
        name: Faker::Music.band
    )
    SellerAccount.create(
        user_id: u.id,
        seller_id: s.id,
        role: 0
    )
end