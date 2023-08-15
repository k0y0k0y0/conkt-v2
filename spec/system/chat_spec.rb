require 'rails_helper'

RSpec.describe 'DMメッセージに関するテスト', type: :system do

describe 'バリデーションのテスト' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:room) { FactoryBot.create(:room, sender: user, recipient: second_user) }
  let(:chat) { FactoryBot.create(:chat, user: user, room: room) }

  context '200文字以上のメッセージを送る場合' do
    it 'メッセージ送信ができない' do
        chat.message = 'message' * 201
        expect(chat).not_to be_valid
      end
    end