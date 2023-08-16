require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "プロフィール登録のテスト" do
    let(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user_id: user.id) }
    describe "登録確認" do
      context "必要な情報が全て登録された場合" do
        it "プロフィールが登録ができる" do
          expect(profile).to be_valid
        end
      end
    end
    describe "nameカラムの確認" do
      context "名前が登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.name = ""
          expect(profile).not_to be_valid
        end
      end
    end
    describe "sexカラムの確認" do
      context "性別が登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.sex = ""
          expect(profile).not_to be_valid
        end
      end
    end
    describe "ageカラムの確認" do
      context "年齢が登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.age = ""
          expect(profile).not_to be_valid
        end
      end
    end
    describe "workカラムの確認" do
      context "仕事が登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.work = ""
          expect(profile).not_to be_valid
        end
      end
    end
    describe "hobbyカラムの確認" do
      context "趣味が登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.hobby = ""
          expect(profile).not_to be_valid
        end
      end
    end
    describe "likesカラムの確認" do
      context "好きなことが登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.likes = ""
          expect(profile).not_to be_valid
        end
      end
    end
    describe "commentカラムの確認" do
      context "一言が登録されなかった場合" do
        it "プロフィールの登録ができない" do
          profile.comment = ""
          expect(profile).not_to be_valid
        end
      end
    end
  end
end
