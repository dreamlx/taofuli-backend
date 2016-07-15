require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "is valid" do
    expect(create(:ticket)).to be_valid
  end
end
