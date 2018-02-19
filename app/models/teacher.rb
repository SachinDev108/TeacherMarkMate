class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :subjects
  has_many :children
  has_many :sheets
  after_create :send_reset_password_link

  private
  def send_reset_password_link
    send_reset_password_instructions
  end  
end
