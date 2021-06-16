class Company < ApplicationRecord
    enum status: { inativo: 0, ativo: 1 }
    cnpj_pattern = /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/
    
    #implementar token automático
    validates :cnpj, :corporate_name, :billing_email, :company_admin_email, :company_token, uniqueness: true, presence: true
    validates :fantasy_name, :billing_address, :status, presence: true
    validates :cnpj, length: { is: 18 }, format: {with: cnpj_pattern }

end