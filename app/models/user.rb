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
  has_one :group

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_overdue?
    overdue().count > 0
  end

  def overdue
    overdue = []
    tasks.each do |t|
      if t.schedule.all_overdue().count > 0
        overdue.push(t)
      end
      if !t.statuses.nil?
        t.statuses.each do |s|
          if s.schedule.all_overdue().count > 0
            overdue.push(s)
          end
        end
      end
    end

    return overdue
  end
end
