require 'rails_helper'

describe 'Admin deletes payment method' do
    it '- Should be able view a delete payment method button' do
        payment = PaymentMethod.create!(name: "102 - Banco XP S.A.", payment_fee: 8, max_pay_fee: 15, payment_type: "pix", status: "ativo")
        admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
        visit root_path 
        click_on 'Área do admin'
        fill_in 'Email', with: 'admin_one@paynow.com.br'
        fill_in 'Senha', with: '123mudar'
        within 'form' do
            click_on 'Entrar'
        end

        click_on 'Meios de pagamento'

        expect(page).to have_button("❌")
        expect(page).to have_text(payment.name)
        expect(page).to have_text(payment.max_pay_fee)
    end

    it '- Should be able delete a payment method' do
        payment = PaymentMethod.create!(name: "102 - Banco XP S.A.", payment_fee: 8, max_pay_fee: 15, payment_type: "pix", status: "ativo")
        admin = Admin.create!(email: 'admin_one@paynow.com.br', password: '123mudar')
            
        visit root_path 
        click_on 'Área do admin'
        fill_in 'Email', with: 'admin_one@paynow.com.br'
        fill_in 'Senha', with: '123mudar'
        within 'form' do
            click_on 'Entrar'
        end

        click_on 'Meios de pagamento'

        expect { click_on '❌' }.to change { PaymentMethod.count }.by(-1)
        expect(current_path).to eq(admin_payment_methods_path)
        expect(page).to have_content('Meio de pagamento apagado com sucesso !')
    end

end