# SessionHelper
module SessionsHelper
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def log_out
    session[:user_id] = nil
  end
end
