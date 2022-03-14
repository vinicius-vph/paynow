class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  admin_email_pattern = /[a-z._\-]+@paynow\.com\.br/
  validates :email, format: { with: admin_email_pattern }
end
