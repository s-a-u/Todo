class AddPositionToTask < ActiveRecord::Migration
  def up
    add_column :tasks, :position, :integer, default: 0

    Project.includes(:tasks).each do |project|
      Task.transaction do
        project.tasks.each_with_index do |task, index|
          task.position = index
          task.save
        end
      end
    end
  end

  def down
    remove_column :tasks, :position
  end
end
