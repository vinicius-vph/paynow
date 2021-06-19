require 'rails_helper'

describe 'Admin updates payment method' do
    it '- Should be able view a update payment method page' do
        payment = PaymentMethod.create!(name: "246 - Banco ABC Brasil S.A.", payment_fee: 4, max_pay_fee: 30, payment_type: "boleto_bancario", status: "ativo")
        admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
        visit root_path
        click_on 'Área do admin'
        fill_in 'Email', with: 'admin_one@paynow.com.br'
        fill_in 'Senha', with: '123mudar'
        within 'form' do
            click_on 'Entrar'
        end

        click_on 'Meios de pagamento'
        click_on '✏️'

        expect(page).to have_text("Editar meio de pagamento")
        expect(page).to have_text("Nome")
        expect(page).to have_text("Taxa por Cobrança")
        expect(page).to have_text("Tipo")
        expect(page).to have_text("Status")
        expect(page).to have_button("Atualizar")
    end

    it '- Should be able update a payment method' do
        payment = PaymentMethod.create!(name: "246 - Banco ABC Brasil S.A.", payment_fee: 4, max_pay_fee: 30, payment_type: "boleto_bancario", status: "ativo")
        admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
        visit root_path
        click_on 'Área do admin'
        fill_in 'Email', with: 'admin_one@paynow.com.br'
        fill_in 'Senha', with: '123mudar'
        within 'form' do
            click_on 'Entrar'
        end

        click_on 'Meios de pagamento'
        click_on '✏️'

        fill_in 'Taxa por Cobrança', with: 2.0
        fill_in 'Taxa Máxima em R$', with: 2.5
        select 'Inativo', from: 'Status'

        click_on 'Atualizar'

        expect(page).to have_text('Meio de pagamento atualizado com sucesso !')
        expect(current_path).to eq(admin_payment_methods_path)
        expect(page).to have_text('246 - Banco ABC Brasil S.A.')
        expect(page).to have_text('2.0 %')
        expect(page).to have_text('R$ 2.5')
        expect(page).to have_text('inativo')

    end
end