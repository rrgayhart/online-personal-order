class OrderItem < ActiveRecord::Base
  validates :last_purchase, presence: true
  validates_uniqueness_of :name, :case_sensitive => false
  has_many :order_item_locations
  has_many :locations, through: :order_item_locations

  def postpone
    self.frequency += 1
    self.save
  end

  def purchase
    self.last_purchase = Date.today
    self.save
  end

  def set_due
    difference = self.frequency - months_since_purchase
    if difference > 0
      self.frequency = difference
    else
      self.frequency = 1
      self.last_purchase = Date.today.last_month
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
