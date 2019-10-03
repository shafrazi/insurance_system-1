class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # def current_customer
  #   @current_customer = Customer.find(params[:id])
  #   #code
  # end
end
