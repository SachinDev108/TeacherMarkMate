class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessor :created_by, :users, :period
  has_many :subjects, :dependent => :destroy
  has_many :children, :dependent => :destroy
  has_many :sheets, :dependent => :destroy
  has_many :sub_teachers, :class_name => 'Teacher', :foreign_key => :parent_id
  has_many :subscriptions, :dependent => :destroy

  after_save :save_subscription
  #after_create :send_reset_password_link
  ROLES = { headTeacher: 'HeadTeacher', subTeacher: 'SubTeacher' }


  def is_head?
    role == ROLES[:headTeacher]
  end

  def is_teacher?
    role == ROLES[:subTeacher]
  end

  def plan
    subscriptions.is_active.first
  end

  private

  def send_reset_password_link
    send_reset_password_instructions
  end 

  def save_subscription
    if admin_id?
      subscriptionType = SubscriptionType.find(5)
      subscription = subscriptionType.subscriptions.find_or_create_by({teacher_id: id})
      subscription.update_attributes(period: period, no_of_users: users, payment_status: 'Completed', payment_date: Time.now, status: true, payment_type: 'Cash')
    end
  end 
end
