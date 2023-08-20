require 'rails_helper'

RSpec.describe 'AIニックネーム命名に関するテスト', type: :system do
  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end


  describe 'AIニックネームのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }

    before do
      user_login
    end
    context 'AIニックネームをクリックすると' do
      it 'ニックネームが命名される' do
        click_on 'マイページ'
        click_on 'AIにニックネームをつけてもらおう!!'
        expect(page).to have_content 'chatGPTによるニックネーム命名'
      end
    end
  end
end