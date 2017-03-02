class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.belongs_to :project, index: true

      t.timestamps null: false
    end
  end
end
