class Company < ApplicationRecord
    enum status: { inativo: 0, ativo: 1 }
    
    #gerar testes e implementar token automático
    validates :fantasy_name, :cnpj, :corporate_name, :billing_email, :company_admin_email, :company_token, uniqueness: true, presence: true
    validates :billing_address, :status, presence: true
end