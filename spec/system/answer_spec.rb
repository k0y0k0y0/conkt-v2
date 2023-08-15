require 'rails_helper'

RSpec.describe '相性診断の回答に関するテスト', type: :system do
  describe '回答のテスト' do
    before do
      visit new_user_registration_path
      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password]', with: '12345678'
      fill_in 'user[password_confirmation]', with: '12345678'
      click_button '登録'

      visit new_profile_path
      fill_in 'profile[name]', with: 'taro'
      choose 'profile[sex]', with: 'man'
      fill_in 'profile[age]', with: '30'
      fill_in 'profile[work]', with: '会社員'
      fill_in 'profile[hobby]', with: '釣り'
      fill_in 'profile[likes]', with: '食べること'
      fill_in 'profile[comment]', with: 'よろしく'
      attach_file 'profile[icon]', File.join(Rails.root, 'spec/fixtures/test.jpg')
      click_on '登録'
    end

    context '入力事項を全て入れた場合' do
      it '相性診断の回答が登録できる' do

        choose 'answer[response]', option: response[false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
        click_on '登録'
        expect(page).to have_content '回答が登録されました！'
      end
    end
  end
end