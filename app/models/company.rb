class Company < ActiveRecord::Base
  has_many :tasks
  attr_accessible :info, :name
end
