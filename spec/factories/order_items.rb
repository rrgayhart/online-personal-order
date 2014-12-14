# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    name 'qtips'
    frequency 1
    frequency_type 'month'
    last_purchase Date.today.months_ago(1)

    trait :bought_today do
      last_purchase Date.today
    end

    trait :bought_six_months_ago do
      last_purchase Date.today.months_ago(6)
    end

  end
end
