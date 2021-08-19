require 'rails_helper'

describe 'Client reads payment methods' do
    it '- Should be able reads the payment_methods index page whith empty info' do
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
        
        expect(current_path).to eq(client_payment_methods_path)
        expect(page).to have_text(client.email)
        expect(page).to have_text('Paynow - Meios de pagamento disponiveis')
        expect(page).to have_link('Voltar')
        expect(page).to have_content('#')
        expect(page).to have_content('Nome')
        expect(page).to have_content('Taxa por Cobrança')
        expect(page).to have_content('Taxa Máxima em R$')
        expect(page).to have_content('Tipo')
        expect(page).to have_content('Habilitado?')
        expect(page).to have_content('Aceitar esse meio pagamento')
        expect(page).to have_content('Nenhum meio de pagamento dísponivel')

    end

    it '- Should be able reads a payment_method details' do
        payment = PaymentMethod.create!(name: "246 - Banco ABC Brasil S.A.", payment_fee: 4, max_pay_fee: 30, payment_type: "boleto_bancario", status: "ativo")
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

        expect(page).to have_content(payment.name)
        expect(page).to have_content(payment.payment_fee)
        expect(page).to have_content(payment.max_pay_fee)
        expect(page).to have_content(payment.payment_type)

    end

    it '- Should not be able reads a payment_method with status inativo' do
        pm_one = PaymentMethod.create!(name: "246 - Banco ABC Brasil S.A.", payment_fee: 4, max_pay_fee: 30, payment_type: "boleto_bancario", status: "ativo")
        pm_two = PaymentMethod.create!(name: "Martercard", payment_fee: 10, max_pay_fee: 40, payment_type: "cartao_de_credito", status: "inativo")
        pm_three = PaymentMethod.create!(name: "077 - Banco INTER S.A.", payment_fee: 1, max_pay_fee: 5, payment_type: "pix", status: "ativo")
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

        expect(page).to have_content(pm_one.name)
        expect(page).to have_content(pm_three.name)
        expect(page).to_not have_content(pm_two.name)
    end
end