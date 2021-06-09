require 'rails_helper'

describe 'Admin creates payment type' do
    it '- Should be able create a new payment type' do
        admin_one_login

        click_on 'Meios de pagamento'
        click_on 'Criar novo'
        fill_in 'Nome', with: 'Pix - Banco Inter 077'
        fill_in 'Taxa por cobrança', with: 1
        fill_in 'Taxa máxima em R$', with: 2
        fill_in 'Tipo', with: 'pix'
        fill_in 'Status', with: 'ativo'

        within 'form' do
            click_on 'Salvar'
        end
    end
end