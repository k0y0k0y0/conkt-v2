require 'rails_helper'

RSpec.describe 'DMメッセージに関するテスト', type: :system do
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

  describe 'DMのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }
    let!(:room) { FactoryBot.create(:room, sender: user, recipient: second_user) }
    let(:chat) { FactoryBot.create(:chat, user: user, room: room) }

  context '相互フォローになった場合' do
    it 'DMを始めるリンクが表示される' do
      user_login
      click_on '参加者一覧'
      click_on 'test2'
      click_on 'フォローする'
      click_on 'ログアウト'

      click_on 'ログイン'
      fill_in 'user[email]', with: 'test_admin@example.com'
      fill_in 'user[password]', with: '87654321'
      click_button 'ログイン'

      click_on '参加者一覧'
      click_on 'test1'
      click_on 'フォローする'
      expect(page).to have_content 'DMを始める'
      end
    end

  context 'DMでメッセージをした場合' do
    it 'メッセージが表示される' do
      user_login
      click_on '参加者一覧'
      click_on 'test2'
      click_on 'フォローする'
      click_on 'ログアウト'

      click_on 'ログイン'
      fill_in 'user[email]', with: 'test_admin@example.com'
      fill_in 'user[password]', with: '87654321'
      click_button 'ログイン'

      click_on '参加者一覧'
      click_on 'test1'
      click_on 'フォローする'
      click_on 'DMをする'
      within 'form' do
        fill_in 'メッセージを入力', with: chat.message
        click_button '送信'
      end
      sleep(1)
      expect(page).to have_content 'Sample message'
      end
    end
  end
end