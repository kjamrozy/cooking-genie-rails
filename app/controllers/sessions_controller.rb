class SessionsController < ApplicationController
  skip_before_action :require_login
  def new
    render 'new', layout: 'before_auth'
  end
  def create
    @user = User.find_by_email(params[:email])
    if @user.nil?
      puts 'mark'
      flash[:errors] = ['Invalid email/password']
      render :new, layout: 'before_auth'
    else
      log_in(@user)
      redirect_to(root_path)
    end
  end

  def destroy
    log_out
    flash[:notice] = 'Successfully logged out!'
    redirect_to '/signin'
  end
end
