class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    if current_user && current_user.profile
      @profiles = Profile.where.not(user_id: current_user.id)

      if current_user.profile.sex == 'man'
        @profiles = @profiles.where(sex: 'woman')
      elsif current_user.profile.sex == 'woman'
        @profiles = @profiles.where(sex: 'man')
      else
      redirect_to new_profile_path
      end
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @icon_url = @profile.icon.present? ? @profile.icon.url : Profile.default_icons.sample
    @favorite = current_user.favorites.find_by(profile_id: @profile.id)

    if current_user.answer.present? && @profile.user.answer.present?
      @love_match = calculate_love_match(current_user.answer.response, @profile.user.answer.response)
    else
      @love_match = nil
    end
  end

  def new
    if current_user.profile.nil?
      @profile = Profile.new
    else
      redirect_to pages_show_path
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    unless @profile.user == current_user
      redirect_to profiles_path
    end
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id

    if @profile.icon.blank?
      @profile.icon = Profile.default_icons.sample
    end

    respond_to do |format|
      if @profile.save
        format.html { redirect_to new_answer_path(current_user), notice: "プロフィールを登録しました！" }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to pages_show_path(current_user), notice: "プロフィールを更新しました！" }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  #相性診断の％計算
  def calculate_love_match(user1, user2)
    score = calculate_score(user1, user2)
    min_percentage = 25
    percentage_increase_per_point = 5
    min_percentage + (score * percentage_increase_per_point)
  end

  #相性診断の回答一致数
  def calculate_score(user1, user2)
    score = 0
    user1.each_with_index do |love_answer, index|
      score += 1 if love_answer == user2[index]
    end
    score
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:icon, :name, :age, :work, :hobby, :likes, :free, :comment, :sex)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end


