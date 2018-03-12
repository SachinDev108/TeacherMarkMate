class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessor :created_by
  has_many :subjects, :dependent => :destroy
  has_many :children, :dependent => :destroy
  has_many :sheets, :dependent => :destroy
  has_many :sub_teachers, :class_name => 'Teacher', :foreign_key => :parent_id
  has_many :subscriptions, :dependent => :destroy
  #after_create :send_reset_password_link
  ROLES = { headTeacher: 'HeadTeacher', subTeacher: 'SubTeacher' }


  def is_head?
    role == ROLES[:headTeacher]
  end

  def is_teacher?
    role == ROLES[:subTeacher]
  end

  private
  def send_reset_password_link
    send_reset_password_instructions
  end  
end
