class Status < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  has_one :schedule, dependent: :destroy

  accepts_nested_attributes_for :schedule

  attr_accessible :info, :task_id, :title, :schedule_attributes, :user_id
end
