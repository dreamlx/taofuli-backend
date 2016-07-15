require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "is valid" do
    expect(create(:customer)).to be_valid
  end
end
