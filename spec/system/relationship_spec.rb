require 'rails_helper'

RSpec.describe 'フォローに関するテスト', type: :system do
  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe 'フォローのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }

    before do
      user_login
    end
    context 'フォローボタンを選択した場合' do
      it 'ユーザーをフォローできる' do
        click_on '参加者一覧'
        click_on 'test2'
        click_on 'フォローする'
        expect(page).to have_content 'フォローを外す'
      end
    end
    context 'フォロー解除ボタンを選択した場合' do
      it 'ユーザーのフォローを解除できる' do
        click_on '参加者一覧'
        click_on 'test2'
        click_on 'フォローする'
        click_on 'フォローを外す'
        expect(page).to have_content 'フォローする'
      end
    end
  end
end