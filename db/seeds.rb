items = ["toilet paper", "tooth paste", "shaving cream", "shampoo/conditioner", "ibprofin", "foundation", "face wash", "mascara", "eye liner", "tampons", "pads", "hair mousse", "hair softner (N4 Super Comb Prep & Protect)", "tooth brush", "dog food", "dog treats", "dog toy", "heartworm meds", "shoes", "plain shirt/top", "plain skirt/jean/skirt", "outfit or dress", "bra and panties", "socks", "deodorant", "contact solution", "contacts", "drano", "lotion (Gilchrist & Soames)", "eye shadow", "toilet bowl cleaner", "Dryer Sheets", "Dog Shampoo", "qTips", "concealer", "dish washing detergent", "hair ties", "ziplock bags", "saran wrap", "aluminum foil", "paper towels", "tupperware", "cleaning spray", "mouth wash", "hand wash", "deodorant", "nail polish remover", "nail file", "jewelry", "benadryl", "dry shampoo", "pjamas", "dish scrubbing pads", "AA Batteries", "swiffer", "laundry detergent", "stamps", "envelopes", "nail buffer", "dry shampoo", "hair spray", "eye shadow brush", "carpet cleaner", "floss"]

item_params_collection = items.collect do |i|
  {name: i, frequency: 0, last_purchase: Date.today.last_month}
end

item_params_collection.each do |item_params|
  OrderItem.create(item_params)
end
