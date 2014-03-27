class History < ActiveRecord::Base
  attr_accessible :completed_for, :schedule_id

  belongs_to :schedule
end
