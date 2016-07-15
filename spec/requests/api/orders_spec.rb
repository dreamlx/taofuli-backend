require 'rails_helper'

RSpec.describe "orders" do
  describe "POST #create" do
    it "create a new order" do
      Order.delete_all
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      event = create(:event)
      post "/api/orders", {event_id: event.id}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      expect(Order.count).to eq 1
    end
  end

  describe "GET #index" do
    it "get someone's orders" do
      Order.delete_all
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      order = create(:order, user_id: user.id)
      get "/api/orders", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["orders"].first
      expect(json["id"]).to eq order.id
      expect(json["date"]).to eq I18n.l(order.date, format: :long)
      expect(json["event_title"]).to eq order.event.title
      expect(json["amount"]).to eq order.amount
      expect(json["state"]).to eq order.state
    end
  end
end