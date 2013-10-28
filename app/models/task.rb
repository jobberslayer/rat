class Task < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :company
  belongs_to :user
  has_one :schedule
  attr_accessible :company_id, :title, :info, :schedule_id, :parent_id, :lft, :rgt, :schedule_attributes, :user_id

  accepts_nested_attributes_for :schedule, allow_destroy: true
end
