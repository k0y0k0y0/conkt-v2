require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'Roomモデルのbetweenスコープのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }

    context 'senderとresipientが相互関係にある場合' do
      it 'チャットルームを取得できる' do
        room = FactoryBot.create(:room, sender: user, recipient: second_user)
      result = Room.between(user, second_user)

      expect(result).to include(room)
      end
    end

    context 'senderとrecipientが異なる場合' do
      it 'チャットルームを取得できない' do
        room = FactoryBot.create(:room, sender: user, recipient: user)
        result = Room.between(user, second_user)

        expect(result).not_to include(room)
      end
    end
  end
end
