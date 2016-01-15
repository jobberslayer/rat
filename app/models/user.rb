class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
          #:registerable, #turned off registration
          :lockable,
          :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  attr_accessible :title#, :body
  attr_accessible :admin

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :tasks
  has_many :statuses

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_overdue?
    overdue().count > 0
  end

  def companies_with_tasks
    c = []
    tasks.each do |t|
      c.push t.company
    end
    return c.sort {|a,b| a.name <=> b.name}.uniq
  end

  def tasks_for_company(id)
    return self.tasks.where(company_id: id)
  end

  def overdue
    overdue = []
    tasks.each do |t|
      if t.schedule.all_overdue().count > 0
        overdue.push(t)
      end
    end
    statuses.each do |s|
      if s.schedule.all_overdue().count > 0
        overdue.push(s)
      end
    end

    return overdue
  end
end
