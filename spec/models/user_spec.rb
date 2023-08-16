require 'rails_helper'

RSpec.describe User, type: :model do
  describe "モデルのバリデーションのテスト" do
    let!(:user) { FactoryBot.create(:user) }
    describe "新規登録の確認" do
      context "登録事項が全て登録された場合" do
        it "ユーザー登録ができる" do
          expect(user).to be_valid
        end
      end
    end
    describe "emailカラムの確認" do
      context "メールアドレスが登録されなかった場合" do
        it "ユーザー登録ができない" do
          user.email = ""
          expect(user).not_to be_valid
        end
      end
    end
  end
end