require 'rails_helper'

RSpec.describe '相性診断に関するテスト', type: :system do
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

  describe '相性診断のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }

    before do
      user_login
    end
    context '詳細ページにアクセスした場合' do
      it '相性度が表示される' do
        click_on '参加者一覧'
        click_on 'test2'
        expect(page).to have_content '相性率: 25%'
      end
    end
  end
end