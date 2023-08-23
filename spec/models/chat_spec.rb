require 'rails_helper'

RSpec.describe 'DMメッセージに関するテスト', type: :system do

  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe 'メッセージ送信のバリデーションテスト' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:room) { FactoryBot.create(:room, sender: user, recipient: second_user) }
  let(:chat) { FactoryBot.create(:chat, user: user, room: room) }

  before do
    user_login
  end

  context '201文字以上のメッセージを送った場合' do
      it 'メッセージが送信できない' do
          chat.message = 'message' * 201
          expect(chat).not_to be_valid
      end
    end
  end
end
