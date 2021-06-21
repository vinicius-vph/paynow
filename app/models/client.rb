class Client < ApplicationRecord
  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :active_for_authentication?

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable         
  
  email_domain_not_allowed = /\b[A-Z0-9._%a-z\-]+@(yahoo|hotmail|paynow|google)/
  validates :email, format: { without: email_domain_not_allowed, message: "com domínio inválido" }
  validates :email, :password, :company_id, presence: true
  validates :email, uniqueness: true

  def active_for_authentication?
    super && self.check_if_company_is_active && self.is_domain_correct?
  end
  
  def inactive_message
    "Sua conta foi desabilitada, sua empresa está com perfil desativado
    ou os dados de domínio de email não conferem em nossa base. 
    Entre em com a contato@paynow.com para mais informações"
  end
  
  private

  def check_if_company_is_active
    Company.find(self.company_id).ativo?
  end

  def is_domain_correct?
    client_register_email = self.email.split('@').last
    valid_company_find = Company.find(self.company_id)
    company_domain_pattern = valid_company_find.company_admin_email.split('@').last
    
    client_register_email === company_domain_pattern ? true : false   

  end
end  