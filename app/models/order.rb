class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :user_id, presence: true
  validates :event, presence: true
  validate :available_quota
  before_create :set_date

  STATES = ["未派发", "待派发", "已派发"]

  state_machine :state, :initial => :'未派发' do
    event :confirm do
      transition :'未派发' => :'待派发'
    end
    event :pay do
      transition :'待派发' => :'已派发'
    end
  end

  private
    def available_quota
      if event.available_quota <= 0
        errors.add(:base, "没有名额")
      end
    end

    def set_date
      self.date = Date.today
    end
end
