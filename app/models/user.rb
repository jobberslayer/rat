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
end
