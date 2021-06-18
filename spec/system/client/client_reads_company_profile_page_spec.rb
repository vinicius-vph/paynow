require 'rails_helper'

describe 'Client reads company profile page' do
    it '- Should be able reads company profile page' do
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
        
        expect(page).to have_text(client.email)
        expect(current_path).to eq(client_company_path(company))
        expect(page).to have_link('Voltar')
        expect(page).to have_link('Editar cadastro')
        expect(page).to have_content('Detalhes da Empresa')
        expect(page).to have_content('Nome Fantasia')
        expect(page).to have_content('Razão Social')
        expect(page).to have_content('CNPJ')
        expect(page).to have_content('Endereço de faturamento')
        expect(page).to have_content('Email de faturamento')
        expect(page).to have_content('Email do administrador')
        expect(page).to have_content('Token')
        expect(page).to have_content('Situação cadastral')
        expect(page).to have_button('Renovar Token')
    end
end