require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is valid" do
    expect(create(:event)).to be_valid
  end
end
