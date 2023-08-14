class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    # ゲストユーザーのプロフィール情報作成もしくは更新
    profile = user.profile || user.build_profile
    profile.assign_attributes(
      icon: File.new(Rails.root.join('app', 'assets', 'images', 'guest.png')),
      name: 'ゲスト',
      sex: 'man',
      age: 100,
      work: 'ゲストの職業',
      hobby: 'ゲストの趣味',
      likes: 'ゲストの好きなこと',
      comment: 'ゲストからのメッセージ',
    )
    profile.save

    #相性診断(全てtrue)
    answer = user.answer || user.build_answer
    answer.assign_attributes(
      response: [true] * 15
    )
    answer.save

    redirect_to pages_index_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_guest_sign_in
    user = User.guest_admin
    sign_in user
    redirect_to rails_admin_path, notice: '管理者ユーザーとしてログインしました。'
  end
end
