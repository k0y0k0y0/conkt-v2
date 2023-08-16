require 'rails_helper'

RSpec.describe 'アクセス制限に関するテスト', type: :system do
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

  describe 'ページ移動のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }

    context 'ログインしていない場合' do
      it 'マイページが表示されない' do
        visit pages_index_path
        expect(page).not_to have_content 'マイページ'
      end
    end
    context '一般ユーザーの場合' do
      it '管理画面に行けない' do
        user_login
        expect(page).not_to have_content '管理'
      end
    end
    context '管理者ユーザーの場合' do
      it '管理画面に行ける' do
        admin_user_login
        click_link '管理者ログイン'
        expect(page).to have_content 'サイト管理'
      end
    end
    context '女性がログインした場合' do
      it '男性のプロフィールが表示される' do
        admin_user_login
        click_link '参加者一覧'
        click_link 'test1'
        expect(page).to have_content '男性'
      end
    end
  end
end
