FactoryGirl.define do
  factory :project do
    sequence :name do |n|
      "project #{'%03d' % n}"
    end
    user

    factory :project_with_tasks do
      transient do
        tasks_count 3
      end

      after(:create) do |project, evaluator|
        create_list(:task, evaluator.tasks_count, project: project)
      end
    end
  end
end
