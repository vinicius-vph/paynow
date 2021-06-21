class Company < ApplicationRecord
    has_many :clients
    has_many :company_logs

    enum status: { inativo: 0, ativo: 1 }
    cnpj_pattern = /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/
    
    validates :cnpj, :corporate_name, :billing_email, :company_admin_email, uniqueness: true, presence: true
    validates :fantasy_name, :billing_address, presence: true
    validates :company_token, uniqueness: true
    validates :cnpj, length: { is: 18 }, format: {with: cnpj_pattern }

    before_create do 
        smartToken = SecureRandom.base58(20)

        unless self.company_token and Company.where(company_token: smartToken).any?
            self.company_token = smartToken    
        end
    end

    after_create :create_company_log
    after_update :create_company_log

    def create_company_log
        self.company_logs.create(fantasy_name: self.fantasy_name, cnpj: self.cnpj,
                                corporate_name: self.corporate_name, billing_address: self.billing_address,
                                billing_email: self.billing_email, company_admin_email: self.company_admin_email, 
                                company_token: self.company_token, status: self.status
                                )
    end
end