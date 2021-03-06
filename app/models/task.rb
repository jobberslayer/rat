class Task < ActiveRecord::Base
  attr_accessible :company_id, :category_id, :title, :info, :schedule_attributes, :user_id, :schedule

  belongs_to :company
  belongs_to :user
  belongs_to :category
  has_one :schedule, dependent: :destroy
  has_many :statuses, dependent: :destroy

  accepts_nested_attributes_for :schedule

  validates :title, presence: true, length: { maximum: Rails.application.config.max_title_size }
  validates :info, presence: true 
  validates :company_id, presence: true
  validates :category, presence: true
  validates :user, presence: true
  validates :schedule, presence: true

  def self.filters(args)
    set = Task.select('DISTINCT tasks.*')
    set = set.joins(:company).joins(:category).includes(:statuses)
    if args.has_key?(:category_id) and !args[:category_id].empty?
      set = set.where("category_id = ?", args[:category_id]) 
    end
    if args.has_key?(:company_id) and !args[:company_id].empty?
      set = set.where("company_id = ?", args[:company_id]) 
    end
    if args.has_key?(:user_id) and !args[:user_id].empty?
      set = set.where("tasks.user_id = ? or statuses.user_id=?", args[:user_id], args[:user_id])
    end
    if args.has_key?(:team_id) and !args[:team_id].empty?
      set = set.where("companies.team_id = ?", args[:team_id])
    end
    if args.has_key?(:search_text) and !args[:search_text.empty?]
      sts = "%#{args[:search_text]}%"
      set = set.where("tasks.title like ? or tasks.info like ? or statuses.title like ? or statuses.info like ?",
          sts, sts, sts, sts)
    end

    set
  end

end
