class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_tournament
    @current_tournament ||= Tournament.find_by_id(session[:tournament_id]) 
  end
  helper_method :current_tournament
end
