class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    current_user = resource
    dashboard_index_path
  end
end
