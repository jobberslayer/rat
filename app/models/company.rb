class Company < ActiveRecord::Base
  has_many :tasks
  attr_accessible :info, :name

  validates :name, presence: true, length: { maximum: Rails.application.config.max_title_size }
  validates :info, presence: true 
end
