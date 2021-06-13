require 'rails_helper'

describe 'Visitor visit homepage' do
   it '- Should be able to access homepage' do
    visit root_path

    expect(page).to have_css('h1', text: 'Bem vindo ao PayNow')
    expect(page).to have_css('p', text: 'Receba pagamentos, e resolva suas finanças em um só lugar')
    expect(page).to have_css('p', text: 'Venda com mais meios de pagamento e tenha seu dinheiro na hora')
    expect(page).to have_text('Login')
    expect(page).to have_text('Área do admin')
  end
end