class PagesController < ApplicationController
  def index
  end

  def show
    @profile = current_user.profile
    unless @profile.user == current_user
      redirect_to pages_show_path
    end
  end

  def guest_sign_in
    # ゲストユーザー作成
    guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end

    # ゲストユーザーのプロフィール情報作成
    profile = guest_user.profile || guest_user.build_profile
    profile.assign_attributes(
      icon: File.new(Rails.root.join('app', 'assets', 'images', 'guest.png')),
      name: 'ゲスト',
      sex: 'man',
      age: 100,
      work: 'ゲストの職業',
      hobby: 'ゲストの趣味',
      likes: 'ゲストの好きなこと',
      comment: 'ゲストからのメッセージ'
    )

    sign_in guest_user
    session[:guest_user_id] = guest_user.id
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
