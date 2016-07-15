require 'rails_helper'

RSpec.describe "customers" do
  describe "POST #create" do
    it "create a new customer" do
      valid_attributes = attributes_for(:customer)
      post "/api/customers", valid_attributes
      expect(response).to be_success
      expect(response).to have_http_status(201)
      expect(Customer.count).to eq 1
      expect(Customer.first.name).to eq valid_attributes[:name]
      expect(Customer.first.cell).to eq valid_attributes[:cell]
      expect(Customer.first.qq).to eq valid_attributes[:qq]
      expect(Customer.first.desc).to eq valid_attributes[:desc]
    end
  end
end