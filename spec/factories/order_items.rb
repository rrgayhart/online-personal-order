# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    name 'qtips'
    frequency 1
    frequency_type 'month'
    last_purchase Date.today
  end
end
