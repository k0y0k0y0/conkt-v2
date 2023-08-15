require 'rails_helper'

RSpec.describe 'お気に入りに関するテスト', type: :system do
  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe 'お気に入りのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }

    before do
      user_login
    end
    context 'お気に入りボタンを選択した場合' do
      it 'お気に入りに登録できる' do
        click_on '参加者一覧'
        click_on 'test2'
        click_on 'お気に入りする'
        click_on '気になる一覧'
        expect(page).to have_content 'test2'
      end
    end

    context 'お気に入り一覧ページでユーザーを選択した場合' do
      it 'クリックしたユーザーの詳細ページにいける' do
        click_on '参加者一覧'
        click_on 'test2'
        click_on 'お気に入りする'
        click_on '気になる一覧'
        click_on 'test2'
        expect(page).to have_content 'プロフィール詳細情報'
      end
    end
  end
end
