require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "is valid" do
    expect(create(:admin)).to be_valid
  end
end
