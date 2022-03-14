class Company < ApplicationRecord
  has_many :clients
  has_many :company_logs

  enum status: { inativo: 0, ativo: 1 }
  cnpj_pattern = %r{\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}}

  validates :cnpj, :corporate_name, :billing_email, :company_admin_email, uniqueness: true, presence: true
  validates :fantasy_name, :billing_address, presence: true
  validates :company_token, uniqueness: true
  validates :cnpj, length: { is: 18 }, format: { with: cnpj_pattern }

  before_create do
    smart_token = SecureRandom.base58(20)

    self.company_token = smart_token unless company_token && Company.where(company_token: smart_token).any?
  end

  after_create :create_company_log
  after_update :create_company_log

  def create_company_log
    company_logs.create(fantasy_name: fantasy_name, cnpj: cnpj,
                        corporate_name: corporate_name, billing_address: billing_address,
                        billing_email: billing_email, company_admin_email: company_admin_email,
                        company_token: company_token, status: status)
  end
end
