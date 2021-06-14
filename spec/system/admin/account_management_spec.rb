require 'rails_helper'

describe 'Account Management' do
    context "Login" do
        it '- Should be able create and access an admin account' do
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com.br'
            fill_in 'Senha', with: '123mudar'
            within 'form' do
                click_on 'Entrar'
            end
            
            expect(page).to have_text('Login efetuado com sucesso')
            expect(page).to have_text(admin.email)
            expect(page).to have_button('Sair')
            expect(page).to have_link('Meios de pagamentos')
            expect(page).to have_link('Gerenciar clientes')
            expect(page).to_not have_css('p', text: 'Receba pagamentos, e resolva suas finanças em um só lugar')
            expect(page).to_not have_css('p', text: 'Venda com mais meios de pagamento e tenha seu dinheiro na hora')
            expect(page).to_not have_link('Login')
            expect(page).to_not have_text('Área do admin')
            
        end

        it '- Should not be able access an admin account with invalid password' do
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com.br'
            fill_in 'Senha', with: '1234567'
            within 'form' do
                click_on 'Entrar'
            end
            
            expect(page).to_not have_text('Login efetuado com sucesso')
            expect(page).to_not have_text(admin.email)
            expect(page).to_not have_link('Sair')
            expect(page).to have_text('senha inválida')
        end

        it '- Should not be able access an admin account with invalid email domain' do
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@gmail.com'
            fill_in 'Senha', with: '123mudar'
            within 'form' do
                click_on 'Entrar'
            end
            
            expect(page).to_not have_text('Login efetuado com sucesso')
            expect(page).to_not have_text(admin.email)
            expect(page).to_not have_link('Sair')
            expect(page).to have_text('Email ou senha inválida')
        end
    end

    context "Logout" do
        it '- Should be able sign out the admin' do
            admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com.br'
            fill_in 'Senha', with: '123mudar'
            within 'form' do
                click_on 'Entrar'
            end
            
            click_on 'Sair'

            expect(page).to have_text('Saiu com sucesso')
            expect(page).to_not have_text('admin_one@paynow.com.br')
            expect(page).to have_link('Área do admin')
            expect(page).to_not have_link('Sair')
            expect(current_path).to eq(root_path)
        end
    end
end
