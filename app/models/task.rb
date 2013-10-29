class Task < ActiveRecord::Base
  before_destroy :remove_children_schedules

  acts_as_nested_set 

  belongs_to :company
  belongs_to :user
  has_one :schedule, dependent: :destroy
  attr_accessible :company_id, :title, :info, :schedule_id, :parent_id, :lft, :rgt, :schedule_attributes, :user_id

  accepts_nested_attributes_for :schedule

  private

  def remove_children_schedules
    children.each do |child|
      child.schedule.destroy
    end
  end
end
