class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = current_organisation.users
  end

  def show
    @user = current_user

  end

  def update
    @user = current_user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def change_role
    OrganisationUser.where(user_id: current_user.id, organisation_id: current_organisation.id).update_all({role: params[:user][:role]})
    redirect_to :back
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
