class Event < ActiveRecord::Base
  HEADERS = ["title", "url", "amount", "effective_date", "expire_date", "state"]
  mount_uploader :image, ImageUploader
  STATES = ["有效", "待审核", "无效"]

  has_many :orders
end
