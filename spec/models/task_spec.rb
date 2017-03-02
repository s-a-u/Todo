require 'rails_helper'

RSpec.describe Task, type: :model do

  it 'automatically add task position' do
    project = create(:project_with_tasks, tasks_count: 3)

    expect(project.tasks.pluck(:position)).to eq([0,1,2])
  end

  it 'reorders task position' do
    project = create(:project_with_tasks, tasks_count: 3)
    tasks = project.tasks.to_a

    tasks[0].reorder(2)
    expect(project.tasks(true).to_a).to eq([tasks[1], tasks[2], tasks[0]])

    tasks = project.tasks(true).to_a

    tasks[1].reorder(0)
    expect(project.tasks(true).to_a).to eq([tasks[1], tasks[0], tasks[2]])

    tasks = project.tasks(true)
    tasks[1].reorder(1)
    expect(project.tasks(true).to_a).to eq(tasks)
  end

end
