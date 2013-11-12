class Category < ActiveRecord::Base
  has_many :tasks
  attr_accessible :description, :name
end
