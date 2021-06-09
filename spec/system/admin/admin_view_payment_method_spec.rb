require 'rails_helper'

describe 'Admin creates payment type' do
    it '- Should be able create a new payment type' do
        PaymentMethod.create!(name: 'Pix - 341 Banco Itaú', payment_fee: 10, max_pay_fee: 20, type: :pix, status: :activated)
        PaymentMethod.create!(name: 'Boleto - 077 Banco Inter', payment_fee: 5, max_pay_fee: 10, type: :boleto, status: :activated)

        admin_one_login

        click_on 'Meios de pagamento'
  
        expect(page).to have_link('Criar novo')
        expect(page).to have_content('Boleto - 077 Banco Inter')
        expect(page).to have_content('5%')
        expect(page).to have_content('R$ 10,00')
        expect(page).to have_content('Pix - 341 Banco Itaú')
        expect(page).to have_content('10%')
        expect(page).to have_content('R$ 20,00')

    end
end