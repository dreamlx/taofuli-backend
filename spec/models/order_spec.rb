require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid" do
    expect(create(:order)).to be_valid
  end

  it "failed if same user order same event" do
    user = create(:user)
    event = create(:event)
    valid_order = create(:order, user_id: user.id, event_id: event.id)
    invalid_order = build(:order, user_id: user.id, event_id: event.id)
    invalid_order.valid?
    expect(invalid_order).to be_invalid
    expect(invalid_order.errors[:event_id].first).to eq I18n.t('errors.messages.taken')
  end
end