FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'password'

    factory :user_with_projects do
      transient do
        projects_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:project_with_tasks, evaluator.projects_count, user: user)
      end
    end
  end
end
