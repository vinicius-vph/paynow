require 'rails_helper'
describe 'Client rgister with company already registred' do
    context 'Sign up' do
        it '- Should be able creates a new client with active company' do
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

        it '- Should not be able creates a new client with inactive company' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :inativo
            )

            company2 = Company.create!(fantasy_name: "Mercado do Bairro", cnpj: "12.345.351/0001-02", 
                corporate_name: "Mercado do Bairro VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 21 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@cmercado.com.br", company_admin_email: "admin@mercado.com.br", 
                company_token: "0dGR548e9Hoa6flfLW897", status: :ativo
            )
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
            click_on 'Cadastrar novo usuário'
    
            expect(current_path).to eq(new_client_registration_path)
            expect(page).to have_content("Email")
            expect(page).to have_content("Senha")
            expect(page).to have_content("Confirmar senha")
            expect(page).to have_content("Escolha sua Empresa")
            expect(page).to_not have_content("Codeplay Cursos")
            expect(page).to have_content("Mercado do Bairro")
            expect(page).to have_button("Cadastrar")
        end

        it '- Should not be able creates a new client with active company an invalid domain' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )

            company2 = Company.create!(fantasy_name: "Mercado do Bairro", cnpj: "12.345.351/0001-02", 
                corporate_name: "Mercado do Bairro VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 21 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@cmercado.com.br", company_admin_email: "admin@mercado.com.br", 
                company_token: "0dGR548e9Hoa6flfLW897", status: :inativo
            )

            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
            click_on 'Cadastrar novo usuário'
    
            fill_in 'Email', with: 'admin@jonhdoe.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirmar senha', with: '123456'
            select 'Codeplay Cursos', from: 'Escolha sua Empresa'
    
            click_on 'Cadastrar'
    
            expect(current_path).to eq(root_path)
            expect(current_path).to_not eq(new_client_registration_path)
            expect(page).to_not have_content("Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.")
            expect(page).to_not have_link("Cobranças Efetivadas")
            expect(page).to_not have_link("Meios de pagamento")
            expect(page).to_not have_link("Empresa")
            expect(page).to_not have_link("Meus Produtos")
            expect(page).to_not have_link("Cobranças Pendentes")
            expect(page).to have_content("Sua conta foi desabilitada, sua empresa está com perfil desativado ou os dados de domínio de email não conferem em nossa base. Entre em com a contato@paynow.com para mais informações")
            expect(page).to have_content("Receba pagamentos, e resolva suas finanças em um só lugar")
            expect(page).to have_content("Venda com mais meios de pagamento e tenha seu dinheiro na hora")
        end
    end

    context 'Login' do
        it '- Should be able sign in a client with active company' do
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

        it '- Should not be able sign in a client with inactive company' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :inativo
            )
            client = Client.create!(email: "aadmin@codeplay.com.br", password: '123456', company_id: 1)
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
    
            fill_in 'Email', with: 'aadmin@codeplay.com.br'
            fill_in 'Senha', with: '123456'

            click_on 'Entrar'
    
            expect(current_path).to eq(new_client_session_path)
            expect(page).to have_content("Sua conta foi desabilitada, sua empresa está com perfil desativado ou os dados de domínio de email não conferem em nossa base. Entre em com a contato@paynow.com para mais informações")
            expect(page).to_not have_content("Login efetuado com sucesso!")
            expect(page).to_not have_link("Cobranças Efetivadas")
            expect(page).to_not have_link("Meios de pagamento")
            expect(page).to_not have_link("Empresa")
            expect(page).to_not have_link("Meus Produtos")
            expect(page).to_not have_link("Cobranças Pendentes")
        end
    end
    context 'Logout' do
        it '- Should be able creates a new client with active company' do
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