require 'rails_helper'

describe 'Account Management' do

    context "Registration" do
        it '- Should be able create an admin account' do
            Admin.create!(email: 'admin_one@paynow.com', password: '123mudar')
            
            visit root_path
            click_on 'Área do admin'
            fill_in 'Email', with: 'admin_one@paynow.com'
            fill_in 'Senha', with: '123mudar'
            click_on 'Entrar'
            
            expect(page).to have_text('Login efetuado com sucesso')
            expect(page).to_not have_link('Sair')
            expect(page).to_not have_css('p', text: 'Receba pagamentos, e resolva suas finanças em um só lugar')
            expect(page).to_not have_css('p', text: 'Venda com mais meios de pagamento e tenha seu dinheiro na hora')
            
        end
    end


end
