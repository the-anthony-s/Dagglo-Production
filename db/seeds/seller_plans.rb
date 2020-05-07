SellerPlan.create(
    name: "Early Access",
    stripe_id: "Early-Access",
    amount: 000,
    interval: "month",
    pause: false
)

SellerPlan.create(
    name: "Basic",
    stripe_id: "Basic-Monthly",
    amount: 19900,
    interval: "month",
    num_of_products: 50,
    num_of_locations: 5,
    num_of_sub_accounts: 5,
    analytics: "Basic",
    pause: true
)

SellerPlan.create(
    name: "Advanced",
    stripe_id: "Advanced-Monthly",
    amount: 29900,
    interval: "month",
    num_of_products: 200,
    num_of_locations: 15,
    num_of_sub_accounts: 15,
    analytics: "Advanced",
    pause: true
)