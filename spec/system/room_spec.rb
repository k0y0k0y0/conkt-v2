require 'rails_helper'

RSpec.describe 'DM一覧に関するテスト', type: :system do
  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe 'DMメッセージの一覧画面のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }


    before do
      user_login
    end
    context 'メッセージ一覧画面をクリックすると' do
      it 'やり取りしている人一覧が表示される' do
        click_on 'メッセージ一覧'
        expect(page).to have_content 'メッセージ一覧'
      end
    end
  end
end