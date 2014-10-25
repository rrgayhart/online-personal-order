class Location < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => false
  has_many :order_items_locations
  has_many :order_items, through: :order_item_locations
end
