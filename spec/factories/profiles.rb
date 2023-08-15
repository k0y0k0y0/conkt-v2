FactoryBot.define do
  factory :profile do
    name { 'test1' }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
    sex { 'man' }
    age { '20' }
    work { '会社員' }
    hobby { '釣り' }
    likes { '食べること' }
    comment { 'よろしくお願いします！' }
  end

  factory :second_profile, class: Profile do
    name { 'test2' }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
    sex { 'woman' }
    age { '30' }
    work { 'OL' }
    hobby { '旅行' }
    likes { '寝ること' }
    comment { 'よろしく！' }
  end

  factory :third_profile, class: Profile do
    name { 'test3' }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
    sex { 'woman' }
    age { '20' }
    work { '看護師' }
    hobby { '料理' }
    likes { '走ること' }
    comment { 'よろしくお願いします' }
  end
end