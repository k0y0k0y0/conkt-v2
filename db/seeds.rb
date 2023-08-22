require 'faker'

#質問内容
Question.create!(content: "どちらかというとインドア派よりアウトドア派だ")
Question.create!(content: "ファッションやグルメにこだわりがある")
Question.create!(content: "一人でやる趣味が多い")
Question.create!(content: "行動する前によく考える")
Question.create!(content: "多少値段が高くても、気に入ったものは買うことが多い")
Question.create!(content: "お酒は好きな方だ")
Question.create!(content: "恋人と飲みにいくならお洒落なお店に行きたい")
Question.create!(content: "スポーツはやるより観る方が好きだ")
Question.create!(content: "本を読むことが好きだ")
Question.create!(content: "些細なことで恋人と喧嘩をしたら自分から謝る方だ")
Question.create!(content: "恋人ができたら服装や趣味を合わせる方だ")
Question.create!(content: "恋人がいても自分の時間は欲しい")
Question.create!(content: "ホラー映画は好きな方だ")
Question.create!(content: "一人で旅行に行ったことがある、または行ってみたい")
Question.create!(content: "全てを投げ出して、船で世界を旅しながら生活できたら楽しいと思うか")


# ユーザーデータの投入
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
end

# プロフィールデータの投入
5.times do |n|
  profile = Profile.create!(
    icon: File.open("app/assets/images/default_icon1.jpg"),
    name: Faker::Name.name,
    sex: ["男性", "女性"].sample,
    age: Faker::Number.between(from: 18, to: 80),
    work: Faker::Lorem.words(number: rand(1..2)).join(', '),
    hobby: Faker::Lorem.words(number: rand(1..2)).join(', '),
    likes: Faker::Lorem.words(number: rand(1..2)).join(', '),
    comment: Faker::Lorem.sentence,
    user_id: n+1
  )
end

# 相性診断回答データの投入
5.times do |n|
  answer = Answer.create!(
    response: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    user_id: n+1
  )
end

# お気に入りデータの投入
num_users = 5

num_users.times do |user_index|
  user_id = user_index + 1
  other_user_ids = (1..num_users).to_a - [user_id]  # 自分以外のユーザーのIDリスト

  other_user_ids.each do |other_user_id|
    Favorite.create!(
      user_id: user_id,
      profile_id: other_user_id
    )
  end
end
