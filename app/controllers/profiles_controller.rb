class ProfilesController < ApplicationController
  before_action :authenticate_user!
 before_action :set_user
 before_action :owned_profile, only: [:edit, :update]

  def show
    @posts = User.find_by(user_name: params[:user_name]).posts.order('created_at DESC')
  end

  def edit
    @user = User.find_by(user_name: params[:user_name])
  end

  def update
    @user = User.find_by(user_name: params[:user_name])
    if @user.update(profile_params)
      redirect_to profile_path(@user_name) # this may need to be @user.user_name - 12/6/17
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private

 def profile_params
   params.require(:user).permit(:avatar, :bio)
 end

 def owned_profile
   unless current_user == @user
     flash[:alert] = "That profile doesn't belong to you!"
     redirect_to root_path
   end
 end

 def set_user
   @user = User.find_by(user_name: params[:user_name])
 end

end
