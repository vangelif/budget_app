class SplashController < ApplicationController
  # before_action :authenticate_user!
  def index
    redirect_to categories_path if user_signed_in?
  end
end
