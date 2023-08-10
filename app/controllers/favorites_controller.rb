class FavoritesController < ApplicationController

  def create
    @profile = Profile.find(params[:profile_id])
    @favorite = current_user.favorites.create(profile: @profile)
  end

  def destroy
    current_user.favorites.find_by(profile_id: params[:profile_id]).destroy
    @profile = Profile.find(params[:profile_id])
  end

  def show

    @favorites = current_user.favorites.includes(:profile)
  end
end