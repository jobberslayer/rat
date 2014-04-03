class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, :with => :render_missing
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from AbstractController::ActionNotFound, :with => :render_not_found
  rescue_from AbstractController::ActionNotFound, :with => :render_not_found
  rescue_from ActionView::MissingTemplate, :with => :render_not_found

  def render_missing
    render '/layouts/access_denied' 
  end

  def render_not_found(exception)
    logger.info("render_not_found: #{exception.inspect}")
    redirect_to root_path, :notice => "The page was not found. #{exception.inspect}"
  end

  def routing_error
  end
end
