require 'rails_helper'

RSpec.describe OrderItem, :type => :model do
  it 'should exist' do
    expect(create(:order_item)).to eq('boo')
  end
end
