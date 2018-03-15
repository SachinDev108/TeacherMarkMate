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
      if ['1'].include? users
        subscription_type = SubscriptionType.find_by_id('1')
      elsif ['2','3','4','5'].include? users
        subscription_type = SubscriptionType.find_by_id('2')
      elsif ['6','7','8','9','10'].include? users
        subscription_type = SubscriptionType.find_by_id('3')
      else
        subscription_type = SubscriptionType.find_by_id('4')
      end
      subscription_type.subscriptions.create(teacher_id: id, period: period, no_of_users: users, payment_status: 'Completed', payment_date: Time.now, status: true, payment_type: 'Cash',)
    end
  end 
end
