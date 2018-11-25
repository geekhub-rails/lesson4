class SessionsController < ApplicationController
  before_action :require_guest, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @existed_user = User.find_by(name: user_params[:name])
    @user = @existed_user ? @existed_user : User.create(user_params)

    if (user_params[:email] && !@existed_user)
      UserMailer.welcome_email(@user).deliver_later
    end

    if @user.valid? && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path
    end
  end

  def find
    @user = User.find_by(name: params[:user][:name])

    return share_error('No such user') unless @user

    if @user.id != current_user.id
      current_user.users.push(@user)
      flash[:success] = 'Successful shared'
      redirect_to root_path
    else
      share_error('U cant do it with yourself ;)')
    end
  end

  def share
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private

  def share_error(error)
    flash[:error] = error

    @user = User.new
    render 'share'
  end

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
