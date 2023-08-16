require 'rails_helper'

RSpec.describe 'DMメッセージに関するテスト', type: :system do

  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe 'メッセージ送信のテスト' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:room) { FactoryBot.create(:room, sender: user, recipient: second_user) }
  let(:chat) { FactoryBot.create(:chat, user: user, room: room) }

  before do
    user_login
  end

  context 'メッセージを送った場合' do
      it 'メッセージが表示される' do
          chat.message = 'こんにちは'
          expect(chat).not_to have
        end
      end
    end
  end
