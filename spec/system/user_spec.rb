require 'rails_helper'

RSpec.describe 'ユーザー登録ログイン管理ユーザー画面に関するテスト', type: :system do
  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  def admin_user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test_admin@example.com'
    fill_in 'user[password]', with: '87654321'
    click_button 'ログイン'
  end

  describe'ユーザー新規登録テスト' do
    context 'ユーザーが新規作成を全て入力した場合' do
      it 'アカウント登録ができる' do
        visit new_user_registration_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on '登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
  end

  describe 'セッション機能テスト' do
    before do
      @user = FactoryBot.create(:user)
      user_login
    end

    context 'ログインしていない状態でユーザーのデータがある場合' do
      it 'ログインができること' do
      expect(page).to have_content 'ログインしました。'
    end

    context 'ログアウトボタンを押すと' do
      it 'ログアウトができること' do
        click_link 'ログアウト'

        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
end

  describe '管理者権限の機能' do
    let!(:second_user) { FactoryBot.create(:second_user) }
    before do
      admin_user_login
    end
    context '管理者ページにアクセスした場合' do
      it 'アクセスできる' do
        visit rails_admin_path
        expect(page).to have_content 'ユーザー'
        expect(page).to have_content '相性診断の回答'
      end
    end
  end
end
