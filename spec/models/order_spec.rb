require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid" do
    expect(create(:order)).to be_valid
  end
end
