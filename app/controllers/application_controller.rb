class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, :with => :render_missing

  def render_missing
    render '/layouts/access_denied' 
  end
end
