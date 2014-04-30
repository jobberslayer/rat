class Company < ActiveRecord::Base
  has_many :tasks
  belongs_to :team
  attr_accessible :info, :name, :team_id

  validates :name, presence: true, length: { maximum: Rails.application.config.max_title_size }
  validates :info, presence: true 
end
