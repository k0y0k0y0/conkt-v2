require 'rails_helper'

RSpec.describe 'プロフィールに関するテスト', type: :system do

  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'ログイン'
  end

  describe 'プロフィールのテスト' do

    before do
      visit new_user_registration_path
      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password]', with: '12345678'
      fill_in 'user[password_confirmation]', with: '12345678'
      click_button '登録'
    end

    context '入力事項を全て入れた場合' do
      it 'プロフィールが登録できる' do
        visit new_profile_path
        fill_in 'profile[name]', with: 'taro'
        choose 'profile[sex]', with: '男性'
        fill_in 'profile[age]', with: '30'
        fill_in 'profile[work]', with: '会社員'
        fill_in 'profile[hobby]', with: '釣り'
        fill_in 'profile[likes]', with: '食べること'
        fill_in 'profile[comment]', with: 'よろしく'
        attach_file 'profile[icon]', File.join(Rails.root, 'spec/fixtures/test.jpg')
        click_on '登録'
        expect(page).to have_content 'プロフィールを登録しました！'
      end
    end
  end
  describe 'プロフィールのテスト' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:profile) { FactoryBot.create(:profile, user: user) }
  let!(:answer) { FactoryBot.create(:answer, user: user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
  let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }

    context 'プロフィールの編集を押した場合' do
      it 'プロフィールが編集できる' do
        user_login
        click_on '編集'
        fill_in 'profile[name]', with: 'taro edited'
        choose 'profile[sex]', with: '男性'
        fill_in 'profile[age]', with: '31'
        fill_in 'profile[work]', with: 'フリーランス'
        fill_in 'profile[hobby]', with: '旅行'
        fill_in 'profile[likes]', with: '読書'
        fill_in 'profile[comment]', with: 'よろしくお願いします'
        attach_file 'profile[icon]', File.join(Rails.root, 'spec/fixtures/test.jpg')
        click_on '更新'
        expect(page).to have_content '男性'
        expect(page).to have_content '31'
        expect(page).to have_content 'フリーランス'
        expect(page).to have_content '旅行'
        expect(page).to have_content '読書'
        expect(page).to have_content 'よろしくお願いします'
        expect(page).to have_selector('img[src*="test.jpg"]')
        expect(page).to have_content 'プロフィールを更新しました！'
      end
    end
  end
  describe '一覧表示のアクセス制限のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:answer) { FactoryBot.create(:answer, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }
    let!(:second_answer) { FactoryBot.create(:second_answer, user: second_user) }

    context '参加者一覧ページに行った場合' do
      it '自信のプロフィールは表示されない' do
        user_login
        click_on '参加者一覧'
        expect(page).not_to have_content 'test1'
        expect(page).to have_content 'test2'
      end
    end
  end
end