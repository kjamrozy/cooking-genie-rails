class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :require_login
  protect_from_forgery with: :exception
  private

  def require_login
    unless logged_in?
      flash[:errors] = ['Firstly you should sign in!']
      redirect_to(signin_path)
    end
  end
end
