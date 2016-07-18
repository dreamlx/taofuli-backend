class Event < ActiveRecord::Base
  HEADERS = ["title", "amount", "quota", "effective_date", "expire_date", "state"]
  mount_uploader :image, ImageUploader
  STATES = ["有效", "待审核", "无效"]

  has_many :orders
  validates :quota, numericality: {greater_than: 0 }

  def engaged
    orders.count
  end

  def available_quota
    quota - orders.count
  end
end
