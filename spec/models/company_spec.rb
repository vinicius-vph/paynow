require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '- Company uniqueness validation' do
    it { should validate_uniqueness_of(:cnpj).with_message('já está em uso') }
    it { should validate_uniqueness_of(:corporate_name).with_message('já está em uso') }
    it { should validate_uniqueness_of(:billing_email).with_message('já está em uso') }
    it { should validate_uniqueness_of(:company_admin_email).with_message('já está em uso') }
    it { should validate_uniqueness_of(:company_token).with_message('já está em uso') }
  end

  describe '- Company validates presence of parameters' do
    it { should validate_presence_of(:fantasy_name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:corporate_name) }
    it { should validate_presence_of(:billing_address) }
    it { should validate_presence_of(:billing_email) }
    it { should validate_presence_of(:company_admin_email) }
    it { should validate_presence_of(:company_token) }
    it { should validate_presence_of(:status) }
  end

  describe '- Validates cnpj length'do
    it { should validate_length_of(:cnpj).is_equal_to(18).with_message('não possui o tamanho esperado (18 caracteres)') }
  end

  describe '- Validates cnpj pattern' do
    subject {Company.new(fantasy_name: "Codeplay Cursos", cnpj: "24529871000165", 
                              corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                              billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                              billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                              company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )}
    it { should allow_value("24.529.871/0001-65").for(:cnpj)}
    it { should_not allow_value(subject.cnpj).for(:cnpj)}
  end
end