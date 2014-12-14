class OrderItem < ActiveRecord::Base
  validates :last_purchase, presence: true
  validates_uniqueness_of :name, :case_sensitive => false
  has_many :order_item_locations
  has_many :locations, through: :order_item_locations

  def purchase
    self.last_purchase = Date.today
    self.save
  end

  def set_due
    if !due? && months_since_purchase != 0
      update_attributes(frequency: months_since_purchase)
    end
  end

  def postpone
    if due?
      months = months_since_purchase
      self.frequency = months += 1
    else
      self.frequency += 1
    end
    self.save
  end

  def due?
    self.frequency <= months_since_purchase
  end

  def due_soon?
    months_till_purchase == 1
  end

  def months_till_purchase
    self.frequency - months_since_purchase
  end

  def months_since_purchase
    time_since_purchased = Date.today - self.last_purchase
    (time_since_purchased/30).round
  end
end
