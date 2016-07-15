class Api::CustomersController < Api::BaseController
  skip_before_action :authenticate_user!
  def create
    customer = Customer.new(params.permit(:name, :cell, :qq, :desc))
    if customer.save
      render json: {}, status: 201
    else
      return api_error(status: 422)
    end
  end
end