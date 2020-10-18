class ProfilesController < ApplicationController
  def new
    @profile = current_user
  end

  def create
    @profile = current_user
    if @profile.update(profile_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name)
  end
end
