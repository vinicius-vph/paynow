class Client < ApplicationRecord
  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  email_domain_not_allowed = /\b[A-Z0-9._%a-z\-]+@(google|yahoo|hotmail|paynow)/
  validates :email, format: { without: email_domain_not_allowed }
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  before_validation do 
    client_register_email = self.email.split('@').last
    company_find = Company.find(self.company_id)
    company_domain_pattern = company_find.company_admin_email.split('@').last
    
    if client_register_email === company_domain_pattern 
      self.email = self.email 
    else 
      self.email = client_register_email
    end  
  end    
end
