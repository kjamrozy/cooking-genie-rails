class SessionsController < ApplicationController
  def new
    render 'new', layout: 'before_auth'
  end
  def create
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash.now[:errors] = ['Invalid email/password']
      render :new, layout: 'before_auth'
    else
      log_in(@user)
      redirect_to @user
    end
  end

  def destroy
    log_out
    flash[:notice] = 'Successfully logged out!'
    redirect_to '/signin'
  end
end
