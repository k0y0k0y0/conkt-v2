require 'rails_helper'

RSpec.describe '相性診断に関するテスト', type: :system do
  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe '相性診断のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }
    let!(:third_user) { FactoryBot.create(:third_user) }
    let!(:third_profile) { FactoryBot.create(:third_profile, user: third_user) }
    let!(:third_answer) { FactoryBot.create(:third_answer, user: third_user) }

    before do
      user_login
    end
    context '回答が全て一致しない人の詳細ページにアクセスした場合' do
      it '相性度が表示される(最低得点)' do
        click_on '参加者一覧'
        click_on 'test2'
        expect(page).to have_content '相性率: 25%'
      end
    end
    context '回答が全て一致する人の詳細ページにアクセスした場合' do
      it '相性度が表示される(最高得点)' do
        click_on '参加者一覧'
        click_on 'test3'
        expect(page).to have_content '相性率: 100%'
      end
    end
  end
end