require 'spec_helper'

describe Location do
  describe 'Validations' do
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'Associations' do
    it { should have_many :order_item_locations }
    it { should have_many(:order_items).through(:order_item_locations) }
  end
end
