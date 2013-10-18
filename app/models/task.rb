class Task < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :company
  attr_accessible :company_id, :title, :info, :parent_id, :lft, :rgt
end
