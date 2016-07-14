require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    expect(create(:user)).to be_valid
  end
end
