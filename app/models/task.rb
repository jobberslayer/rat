class Task < ActiveRecord::Base
  #before_destroy :remove_children_schedules

  attr_accessible :company_id, :category_id, :title, :info, :schedule_attributes, :user_id

  belongs_to :company
  belongs_to :user
  belongs_to :category
  has_one :schedule, dependent: :destroy
  has_many :statuses, dependent: :destroy

  accepts_nested_attributes_for :schedule

  def self.filters(args)
    set = Task
    set = set.where("category_id = ?", args[:category_id]) if args.has_key?(:category_id) and !args[:category_id].empty?
    set = set.where("company_id = ?", args[:company_id]) if args.has_key?(:company_id) and !args[:company_id].empty?
    if args.has_key?(:user_id) and !args[:user_id].empty?
      set = set.where("user_id = ? or statuses.user_id=?", args[:user_id], args[:user_id])
    end

    set
  end

  private

  def remove_children_schedules
    children.each do |child|
      child.schedule.destroy
    end
  end
end
