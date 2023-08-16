require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:profile) { FactoryBot.create(:profile, user: user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_profile) { FactoryBot.create(:second_profile, user: second_user) }


    context 'お気に入りが重複する場合' do
      it '同じユーザーとプロフィールの組み合わせが重複する場合は無効であること' do
        favorite = Favorite.create(user: user, profile: second_profile)
        duplicate_favorite = Favorite.create(user: user, profile: second_profile)
        expect(duplicate_favorite).not_to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '多:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Profileモデルとの関係' do
      it '多:1となっている' do
        expect(Favorite.reflect_on_association(:profile).macro).to eq :belongs_to
      end
    end
  end
end