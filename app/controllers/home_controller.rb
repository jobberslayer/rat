class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def routing_error
  end
end
