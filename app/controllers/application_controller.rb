class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # attr_accessor :current_tournament
  # helper_method :current_tournament


  def current_tournament
    @current_tournament ||= Tournament.find_by_id(session[:tournament_id]) 
  end
  helper_method :current_tournament
end
