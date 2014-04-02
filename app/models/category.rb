class Category < ActiveRecord::Base
  has_many :tasks
  attr_accessible :description, :name

  validates :name, presence: true, length: { maximum: Rails.application.config.max_title_size }
  validates :description, presence: true 
end
