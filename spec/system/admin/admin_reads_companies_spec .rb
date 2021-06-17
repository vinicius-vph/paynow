require 'rails_helper'

describe 'Admin reads companies' do
    context 'Company summary information' do
        it '- Should be able reads admin companies index page' do
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
                
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com.br'
            fill_in 'Senha', with: '123mudar'
            within 'form' do
                click_on 'Entrar'
            end
    
            click_on 'Gerenciar clientes'
            
            expect(page).to have_text(admin.email)
            expect(page).to have_link('Voltar')
            expect(page).to have_content('Dashboard de clientes')
            expect(page).to have_content('Nome')
            expect(page).to have_content('Cadastro')
            expect(page).to have_content('Histórico cadastral')
            expect(page).to have_content('Editar')
    
        end
    
        it '- Should not be able reads the Admin Dashbord' do
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
                
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com.br'
            fill_in 'Senha', with: '123mudar'
            within 'form' do
                click_on 'Entrar'
            end
    
            click_on 'Gerenciar clientes'
            
            expect(page).to_not eq('Dashboard')
            expect(page).to_not have_link('Gerenciar clientes')
        end
    end

    context 'Company detailed information' do
        it '- Should be able see company details' do
            company = Company.create!(fantasy_name: "Codeplay Cursos", cnpj: "24.529.871/0001-65", 
                                        corporate_name: "CODEPLAY SERVICOS DE VAREJO DO BRASIL LTDA", 
                                        billing_address: "Rua Maestro Cállia - 271 - Vila Mariana - São Paulo - SP", 
                                        billing_email: "faturamento@codeplay.com.br", company_admin_email: "admin@codeplay.com.br", 
                                        company_token: "0dGR548e9Hoa6flfLW421", status: :ativo
                                    )
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
                
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com.br'
            fill_in 'Senha', with: '123mudar'
            within 'form' do
                click_on 'Entrar'
            end 
    
            click_on 'Gerenciar clientes'
            click_on 'Codeplay Cursos'

            expect(page).to have_content('Detalhes do cliente')
            expect(page).to have_content('Nome Fantasia')
            expect(page).to have_content('Razão Social')
            expect(page).to have_content('CNPJ')
            expect(page).to have_content('Token')
            expect(page).to have_content('Endereço de faturamento')
            expect(page).to have_content('Email de faturamento')
            expect(page).to have_content('Email do administrador')
            expect(page).to have_content('Situação cadastral')
            expect(page).to have_link('Editar cadastro')
            expect(page).to have_button('Renovar Token')

        end
    end
end