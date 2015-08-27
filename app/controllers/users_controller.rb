# UsersController
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def index
    @users = User.all
  end

  def show
    set_user
  end

  def new
    @user = User.new
    render 'new', layout: 'before_auth'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Account was successfully created!'
      log_in(@user)
      redirect_to(root_path)
    else
      flash[:errors] = @user.errors.full_messages
      render 'new', layout: 'before_auth'
    end
  end

  def edit
    set_user
  end

  def update
    set_user
    @user.update_attributes(user_params)
    redirect_to @user
  end

  def destroy
    set_user
    @user.destroy
    redirect_to '/signup'
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname,
                                 :password, :password_confirmation,
                                 :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
