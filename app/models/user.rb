class User < ActiveRecord::Base
  HEADERS = ["openid", "name", "gender", "cell", "email", "state"]
  validates :openid, presence: true
  state_machine :state, :initial => :'权益未激活' do
    event :active do
      transition :'权益未激活' => :'权益已激活'
    end
    event :inactive do
      transition :'权益已激活' => :'权益未激活'
    end
  end
end
