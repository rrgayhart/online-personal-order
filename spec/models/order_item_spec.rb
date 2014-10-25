require 'spec_helper'

describe OrderItem do
  describe '.postpone' do
    new_order_item = FactoryGirl.create(:order_item)
    new_order_item.postpone
    expect(new_order_item.frequency).to eq(1)
  end
end
