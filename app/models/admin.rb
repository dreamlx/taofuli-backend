class Admin < ActiveRecord::Base
  HEADERS = ["name", "created_at", "updated_at"]
  has_secure_password
end
