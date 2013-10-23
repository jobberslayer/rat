class Task < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :company
  has_one :schedule
  attr_accessible :company_id, :title, :info, :schedule_id, :parent_id, :lft, :rgt, :schedule_attributes

  accepts_nested_attributes_for :schedule, allow_destroy: true
end
