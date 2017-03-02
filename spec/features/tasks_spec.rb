require 'rails_helper'

RSpec.feature "Tasks", type: :feature do

  let(:user) { create(:user_with_projects) }

  before(:each) do
    sign_in user

    visit root_path
  end

  it 'creates a task' do
    project = user.projects.first
    description = 'new task description'

    within "#project-#{project.id}" do
      fill_in 'New task description', with: description
      click_on 'Add'
    end

    expect(page).to have_content(description)
    expect(project.tasks(true).last.description).to eq(description)
  end

  it 'deletes a task' do
    task = user.projects.first.tasks.first

    find("#delete-task-#{task.id}").click
    expect(page).to_not have_content(task.description)
    expect{Task.find(task.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'updates a task' do
    task = user.projects.first.tasks.first
    description = 'new task description'

    within "#task-#{task.id}" do
      find('.edit').click
      fill_in 'Description', with: description
      click_on 'Save'
    end

    expect(page).to have_content(description)
    expect(task.reload.description).to eq(description)
  end

  it 'marks task as done' do
    task = user.projects.first.tasks.first

    within "#task-#{task.id}" do
      check('Done')
    end

    expect(page).to have_css("#task-#{task.id}.done")
    wait_for_ajax
    expect(task.reload.done).to be_truthy

    within "#task-#{task.id}" do
      uncheck('Done')
    end

    expect(page).to_not have_css("#task-#{task.id}.done")
    wait_for_ajax
    expect(task.reload.done).to be_falsey
  end
end
