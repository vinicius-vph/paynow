require 'rails_helper'

describe 'Admin reads payment type' do
    it '- Should be able reads the payment_methods index page' do
        admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
        visit root_path
        click_on 'Área do admin'
        fill_in 'Email', with: 'admin_one@paynow.com.br'
        fill_in 'Senha', with: '123mudar'
        within 'form' do
            click_on 'Entrar'
        end

        click_on 'Meios de pagamento'
        
        expect(page).to have_text(admin.email)
        expect(page).to have_link('Voltar')
        expect(page).to have_link('Criar novo')
        expect(page).to have_content('#')
        expect(page).to have_content('Nome')
        expect(page).to have_content('Taxa por Cobrança')
        expect(page).to have_content('Taxa Máxima em R$')
        expect(page).to have_content('Tipo')
        expect(page).to have_content('Status')
        expect(page).to have_content('Editar')
        expect(page).to have_content('Apagar')
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

        click_on 'Meios de pagamento'
        
        expect(page).to_not have_text('Dashboard')
        expect(page).to_not have_link('Gerenciar clientes')
    end
end