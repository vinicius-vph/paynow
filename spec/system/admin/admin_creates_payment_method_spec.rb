require 'rails_helper'

describe 'Admin creates payment method' do
    it '- Should be able create a new payment method' do
        admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
        visit root_path
        click_on 'Área do admin'
        fill_in 'Email', with: 'admin_one@paynow.com.br'
        fill_in 'Senha', with: '123mudar'
        within 'form' do
            click_on 'Entrar'
        end

        click_on 'Meios de pagamento'

        click_on 'Criar novo'

        fill_in 'Nome', with: '341 - Banco Itau'
        fill_in 'Taxa por Cobrança', with: 20
        fill_in 'Taxa Máxima em R$', with: 25
        select 'PIX', from: 'Tipo de Pagamento'
        select 'Ativo', from: 'Status'

        click_on 'Enviar'

        expect(page).to have_text('Criado com sucesso')
        expect(page).to have_link('Criar novo')
        expect(page).to have_content('341 - Banco Itau')
        expect(page).to have_content('20.0 %')
        expect(page).to have_content('R$ 25.0')
        expect(page).to have_content('pix')
        expect(page).to have_content('ativo')
    end
end