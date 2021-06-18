require 'rails_helper'

describe 'Client admin update company info' do
    context 'Acess edit page' do
        it '- Should be able access edit page if is valid client admin' do
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
    
            click_on 'Empresa'

            click_on 'Editar cadastro'
            
            expect(current_path).to eq(edit_client_company_path(company))
            expect(page).to have_link('Voltar')
            expect(page).to have_content('Detalhes da Empresa')
            expect(page).to have_content('Nome Fantasia')
            expect(page).to have_content('Razão Social')
            expect(page).to have_content('CNPJ')
            expect(page).to have_content('Endereço de faturamento')
            expect(page).to have_content('Email de faturamento')
            expect(page).to have_content('Email do administrador')
            expect(page).to have_content('Token')
            expect(page).to have_content('Situação cadastral')
            expect(page).to have_button('Atualizar cadastro')
        end        

        it '- Should not be able access edit page if is no client admin' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
            )
            client = Client.create!(email: "user@codeplay.com.br", password: '123456', company_id: 1)
            
            visit root_path
            click_on 'Login'
            click_on 'Sim, sou parceiro Paynow'
    
            fill_in 'Email', with: 'user@codeplay.com.br'
            fill_in 'Senha', with: '123456'
    
            click_on 'Entrar'
    
            click_on 'Empresa'

            click_on 'Editar cadastro'
            
            expect(current_path).to eq(client_root_path)
            expect(page).to have_content('Autorizado somente ao administrador !')
            expect(page).to_not have_content('Detalhes da Empresa')
            expect(page).to_not have_content('Nome Fantasia')
            expect(page).to_not have_content('Razão Social')
            expect(page).to_not have_content('CNPJ')
            expect(page).to_not have_content('Endereço de faturamento')
            expect(page).to_not have_content('Email de faturamento')
            expect(page).to_not have_content('Email do administrador')
            expect(page).to_not have_content('Token')
            expect(page).to_not have_content('Situação cadastral')
            expect(page).to_not have_button('Atualizar cadastro')
        end        
    end

    context 'Update company info' do
        it '- Should be able access edit page if is valid client admin' do
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
    
            click_on 'Empresa'

            click_on 'Editar cadastro'

            fill_in 'Nome Fantasia', with: 'Mercado do Bairro'
            fill_in 'CNPJ', with: '12.123.123/0001-02'
            fill_in 'Razão Social', with: 'ABCD Laticínios'
            fill_in 'Endereço de faturamento', with: 'Rua Maestro Cállia - 50 - Vila Mariana - São Paulo - SP'
            fill_in 'Email de faturamento', with: 'rh@codeplay.com.br'
            
            click_on 'Atualizar cadastro'
            
            expect(page).to have_text('Atualizado com sucesso')
            expect(current_path).to eq(client_company_path(company))
            expect(page).to have_text('Mercado do Bairro')
            expect(page).to have_text('12.123.123/0001-02')
            expect(page).to have_text('ABCD Laticínios')
            expect(page).to have_text('Rua Maestro Cállia - 50 - Vila Mariana - São Paulo - SP')
            expect(page).to have_text('rh@codeplay.com.br')
            expect(page).to have_text('admin@codeplay.com.br')
            expect(page).to have_text('ativo')

        end        
    end
    
end