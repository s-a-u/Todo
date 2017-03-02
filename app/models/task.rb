class Task < ActiveRecord::Base
  belongs_to :project

  validates :description, :project, presence: true

  default_scope ->{ order(:position) }

  before_create :set_position

  def reorder(position)
    return if position == self.position
    a = [position, self.position]
    range = a.min..a.max
    Task.transaction do
      self.project.tasks.where(position: range).update_all('position = position + 1') if position < self.position
      self.project.tasks.where(position: range).update_all('position = position - 1') if position > self.position
      self.position = position
      self.save
    end
  end

  private

  def set_position
    max = self.project.tasks.maximum(:position) || -1
    self.position = max + 1
  end
end
