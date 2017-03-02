FactoryGirl.define do
  factory :task do
    sequence :description do |n|
      "long project description #{'%03d' % n}"
    end
  end
end
