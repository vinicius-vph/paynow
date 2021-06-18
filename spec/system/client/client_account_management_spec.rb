require 'rails_helper'
describe 'Client rgister with company already registred' do
    context 'Sign up' do
        it '- Should be able creates a new client with valid company' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
            click_on 'Cadastrar novo usuário'
    
            fill_in 'Email', with: 'aadmin@codeplay.com.br'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirmar senha', with: '123456'
            select 'Codeplay Cursos', from: 'Escolha sua Empresa'
    
            click_on 'Cadastrar'
    
            expect(current_path).to eq(client_root_path)
            expect(page).to have_content("Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.")
            expect(page).to have_link("Cobranças Efetivadas")
            expect(page).to have_link("Meios de pagamento")
            expect(page).to have_link("Empresa")
            expect(page).to have_link("Meus Produtos")
            expect(page).to have_link("Cobranças Pendentes")
        end
    end

    context 'Login' do
        it '- Should be able creates a new client with valid company' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )
            client = Client.create!(email: "aadmin@codeplay.com.br", password: '123456', company_id: 1)
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
    
            fill_in 'Email', with: 'aadmin@codeplay.com.br'
            fill_in 'Senha', with: '123456'

            click_on 'Entrar'
    
            expect(current_path).to eq(client_root_path)
            expect(page).to have_content("Login efetuado com sucesso!")
            expect(page).to have_link("Cobranças Efetivadas")
            expect(page).to have_link("Meios de pagamento")
            expect(page).to have_link("Empresa")
            expect(page).to have_link("Meus Produtos")
            expect(page).to have_link("Cobranças Pendentes")
        end
    end
    context 'Login out' do
        it '- Should be able creates a new client with valid company' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )
            client = Client.create!(email: "aadmin@codeplay.com.br", password: '123456', company_id: 1)
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
    
            fill_in 'Email', with: 'aadmin@codeplay.com.br'
            fill_in 'Senha', with: '123456'

            click_on 'Entrar'
            click_on 'Sair'
    
            expect(page).to have_content("Saiu com sucesso")
            expect(current_path).to eq(root_path)
            expect(page).to_not have_link("Cobranças Efetivadas")
            expect(page).to_not have_link("Meios de pagamento")
            expect(page).to_not have_link("Empresa")
            expect(page).to_not have_link("Meus Produtos")
            expect(page).to_not have_link("Cobranças Pendentes")
            expect(page).to have_content("Bem vindo ao PayNow")
            expect(page).to have_link("Login")
        end
    end
end