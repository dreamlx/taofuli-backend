class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :user_id, presence: true
  validates :event, presence: true
  validate :available_quota

  private
    def available_quota
      if event.available_quota <= 0
        errors.add(:base, "没有名额")
      end
    end
end
