class Task < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :company
  attr_accessible :company_id, :title, :info, :schedule_type, :parent_id, :lft, :rgt

  def schedule()
    Schedule.from_yaml(schedule_serialized)
  end

  def schedule=(s)
    schedule_serialized = s.to_yaml()
  end
end
