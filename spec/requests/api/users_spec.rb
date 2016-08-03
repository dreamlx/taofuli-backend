require 'rails_helper'

RSpec.describe "users" do
  describe "PATCH #update_profile" do
    it "update user's profile" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      new_attributes = {
        name: "new name",
        cell: "11111111111",
        email: "foobar@example.com",
        gender: "new gender"
      }
      patch "/api/users/update_profile", new_attributes, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq new_attributes[:name]
      expect(json["cell"]).to eq new_attributes[:cell]
      expect(json["email"]).to eq new_attributes[:email]
      expect(json["gender"]).to eq new_attributes[:gender]
      expect(json["state"]).to eq "权益已激活"
    end
  end

  describe "GET #get_info" do
    it "get user's info" do
       user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      get "/api/users/get_info",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq user.name
      expect(json["cell"]).to eq user.cell
      expect(json["email"]).to eq user.email
      expect(json["gender"]).to eq user.gender
    end
  end

  it "create an empty user when no user before" do
    User.delete_all
    valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("long_openid")
      }
    get "/api/users/get_info", {}, valid_header
    expect(response).to be_success
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json["name"]).to be_nil
    expect(json["cell"]).to be_nil
    expect(json["email"]).to be_nil
    expect(json["gender"]).to be_nil
    expect(User.first.openid).to eq "long_openid"
  end
end