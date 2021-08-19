require 'rails_helper'

describe 'Client reads payment methods' do
    context 'PIX' do
        
        it '- Should not be able reads a payment_method with status inativo' do
            # pm_one = PaymentMethod.create!(name: "246 - Banco ABC Brasil S.A.", payment_fee: 4, max_pay_fee: 30, payment_type: "boleto_bancario", status: "ativo")
            # pm_two = PaymentMethod.create!(name: "Martercard", payment_fee: 10, max_pay_fee: 40, payment_type: "cartao_de_credito", status: "inativo")
            payment_method = PaymentMethod.create!(name: "077 - Banco INTER S.A.", payment_fee: 1, max_pay_fee: 5, payment_type: "pix", status: "ativo")
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )
            
            client = Client.create!(email: "admin@codeplay.com.br", password: '123456', company_id: 1)
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
            
            fill_in 'Email', with: 'admin@codeplay.com.br'
            fill_in 'Senha', with: '123456'
            
            click_on 'Entrar'
            
            click_on 'Meios de pagamento'
            click_on '✅'
            
            expect(current_path).to eq(new_client_payment_method_pix_client_pm_path(payment_method))
            # expect(page).to have_content(pm_three.name)
            # expect(page).to_not have_content(pm_two.name)
        end
    end

    context 'Boleto' do
        
        it '- Should not be able reads a payment_method with status inativo' do
            payment_method = PaymentMethod.create!(name: "246 - Banco ABC Brasil S.A.", payment_fee: 4, max_pay_fee: 30, payment_type: "boleto_bancario", status: "ativo")
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )
            
            client = Client.create!(email: "admin@codeplay.com.br", password: '123456', company_id: 1)
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
            
            fill_in 'Email', with: 'admin@codeplay.com.br'
            fill_in 'Senha', with: '123456'
            
            click_on 'Entrar'
            
            click_on 'Meios de pagamento'
            click_on '✅'
            
            expect(current_path).to eq(new_client_payment_method_boleto_bancario_client_pm_path(payment_method))
        end
    end
end