require 'rails_helper'

RSpec.describe '相性診断の回答に関するテスト', type: :system do
  describe '回答のテスト' do
    before do
      Question.create!(content: "Q1.どちらかというとインドア派よりアウトドア派だ")
      Question.create!(content: "Q2.ファッションやグルメにこだわりがある")
      Question.create!(content: "Q3.一人でやる趣味が多い")
      Question.create!(content: "Q4.行動する前によく考える")
      Question.create!(content: "Q5.多少値段が高くても、気に入ったものは買うことが多い")
      Question.create!(content: "Q6.お酒は好きな方だ")
      Question.create!(content: "Q7.恋人と飲みにいくならお洒落なお店に行きたい")
      Question.create!(content: "Q8.スポーツはやるより観る方が好きだ")
      Question.create!(content: "Q9.本を読むことが好きだ")
      Question.create!(content: "Q10.些細なことで恋人と喧嘩をしたら自分から謝る方だ")
      Question.create!(content: "Q11.恋人ができたら服装や趣味を合わせる方だ")
      Question.create!(content: "Q12.恋人がいても自分の時間は欲しい")
      Question.create!(content: "Q13.ホラー映画は好きな方だ")
      Question.create!(content: "Q14.一人で旅行に行ったことがある、または行ってみたい")
      Question.create!(content: "Q15.全てを投げ出して、船で世界を旅しながら生活できたら楽しいと思うか")

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
        choose("answer_0_response_true")
        choose("answer_1_response_true")
        choose("answer_2_response_true")
        choose("answer_3_response_true")
        choose("answer_4_response_true")
        choose("answer_5_response_true")
        choose("answer_6_response_true")
        choose("answer_7_response_true")
        choose("answer_8_response_true")
        choose("answer_9_response_true")
        choose("answer_10_response_true")
        choose("answer_11_response_true")
        choose("answer_12_response_true")
        choose("answer_13_response_true")
        choose("answer_14_response_true")
        click_on '登録'
        expect(page).to have_content '回答が保存されました。'
      end
    end
  end
end