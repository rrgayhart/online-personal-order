require 'spec_helper'

describe OrderItemLocation do
  describe 'Associations' do
    it { should belong_to :order_item }
    it { should belong_to :location }
  end
end
