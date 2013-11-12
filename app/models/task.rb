class Task < ActiveRecord::Base
  before_destroy :remove_children_schedules

  acts_as_nested_set 

  belongs_to :company
  belongs_to :user
  belongs_to :category
  has_one :schedule, dependent: :destroy
  attr_accessible :company_id, :category_id, :title, :info, :schedule_id, :parent_id, :lft, :rgt, :schedule_attributes, :user_id

  accepts_nested_attributes_for :schedule

  def self.filters(args)
    set = Task
    set = set.where("category_id = ?", args[:category_id]) if args.has_key?(:category_id) and !args[:category_id].empty?
    set = set.where("company_id = ?", args[:company_id]) if args.has_key?(:company_id) and !args[:company_id].empty?
    set = set.where("user_id = ?", args[:user_id]) if args.has_key?(:user_id) and !args[:user_id].empty?

    set
  end

  private

  def remove_children_schedules
    children.each do |child|
      child.schedule.destroy
    end
  end
end
