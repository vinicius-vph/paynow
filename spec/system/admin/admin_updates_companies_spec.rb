require 'rails_helper'

describe 'Admin updates company' do
    it '- Should be able view an edit company page' do
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
        click_on 'Editar cadastro'

        expect(current_path).to eq(edit_admin_company_path(company))
        expect(page).to have_content('Editar cliente')
        expect(page).to have_content('Nome Fantasia')
        expect(page).to have_content('Razão Social')
        expect(page).to have_content('CNPJ')
        expect(page).to have_content('Renovar token')
        expect(page).to have_content('Token')
        expect(page).to have_content('Endereço de cobrança')
        expect(page).to have_content('Email de cobrança')
        expect(page).to have_content('Email do administrador')
        expect(page).to have_content('Situação cadastral')
        expect(page).to have_button('Atualizar')

    end

    it '- Should be able update a company info' do
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
        click_on 'Editar cadastro'

        fill_in 'Nome Fantasia', with: 'Mercado do Bairro'
        fill_in 'CNPJ', with: '12123123000102'
        fill_in 'Razão Social', with: 'ABCD Laticínios'
        fill_in 'Endereço de cobrança', with: 'Rua Maestro Cállia - 50 - Vila Mariana - São Paulo - SP'
        fill_in 'Email de cobrança', with: 'rh@codeplay.com.br'
        fill_in 'Email do administrador', with: 'jonhdoe@codeplay.com.br'
        select 'Inativo', from: 'Situação cadastral'

        click_on 'Atualizar'

        expect(page).to have_text('Atualizado com sucesso')
        expect(current_path).to eq(admin_company_path(company))
        expect(page).to have_text('Mercado do Bairro')
        expect(page).to have_text('12123123000102')
        expect(page).to have_text('ABCD Laticínios')
        expect(page).to have_text('Rua Maestro Cállia - 50 - Vila Mariana - São Paulo - SP')
        expect(page).to have_text('rh@codeplay.com.br')
        expect(page).to have_text('jonhdoe@codeplay.com.br')
        expect(page).to have_text('inativo')
    end
end