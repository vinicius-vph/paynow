class Company < ApplicationRecord
    has_many :clients

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
end