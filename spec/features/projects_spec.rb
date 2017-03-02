require 'rails_helper'

RSpec.feature "Projects", type: :feature do

  it 'should display projects with tasks' do
    user = create(:user_with_projects)

    sign_in(user)

    visit '/'
    user.projects.each do |project|
      expect(page).to have_content(project.name)
      project.tasks.each do |task|
        expect(page).to have_content(task.description)
      end
    end
  end

  it 'adds new project' do
    user = create(:user)
    sign_in user

    visit root_path
    click_on 'Add TODO List'

    fill_in 'new-project-name', with: 'new project name'
    click_on 'Add'

    expect(page).to have_content('new project name')
    expect(page).to_not have_css('#new-project-form')
    expect(user.projects(true).first.name).to eq('new project name')
  end

  it 'deletes a project' do
    user = create(:user_with_projects)
    sign_in user

    visit root_path

    project = user.projects.first

    find("#project-#{project.id} .delete").trigger('click')

    expect(page).to_not have_content(project.name)
    expect{Project.find(project.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'updates a project' do
    user = create(:user_with_projects)
    sign_in user

    visit root_path

    project = user.projects.first
    name = 'new project name'

    within "#project-#{project.id} .controls" do
      find('.edit').trigger('click')
      fill_in 'Name', with: name
      click_on 'Save'
    end

    expect(page).to have_content(name)
    expect(project.reload.name).to eq(name)
  end
end
