FactoryBot.define do
  factory :answer do
    response { [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true] }
  end

  factory :second_answer, class: Answer do
    response { [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false] }
  end

  factory :third_answer, class: Answer do
    response { [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true] }
  end
end