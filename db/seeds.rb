items = ["toilet paper", "tooth paste", "shaving cream", "shampoo/conditioner", "ibprofin", "drano", "dish washing detergent", "hair ties", "ziplock bags", "saran wrap", "aluminum foil", "paper towels", "tupperware", "cleaning spray", "mouth wash", "hand wash", "deodorant"]

item_params_collection = items.collect do |i|
  {name: i, frequency: (1..10).to_a.sample, last_purchase: rand(12.months).ago}
end

item_params_collection.each do |item_params|
  OrderItem.create(item_params)
end
