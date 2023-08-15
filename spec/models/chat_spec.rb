require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room, user: user) }

  describe 'バリデーションのテスト' do
    context '200文字以上のメッセージを送る場合' do
      it 'メッセージ送信ができない' do
        chat = Chat.create(user: user, room: room)
        chat.message = 'a' * 201
        expect(chat).not_to be_valid
      end
    end
  end
end