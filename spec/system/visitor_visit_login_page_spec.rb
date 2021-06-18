require 'rails_helper'

describe 'Visitor visit login page' do
  it '- Should be able to access login page' do
    visit root_path
    click_on 'Login'

    expect(current_path).to eq(register_path)
    expect(page).to have_text('Sua empresa já é parceira Paynow?')
    expect(page).to have_text('Quer tornar sua empresa um parceiro Paynow?')
    expect(page).to have_link('Sim, sou parceiro Paynow')
    expect(page).to have_link('Sim, quero ser parceiro Paynow')
  end

  it '- Should be able to access no partner page' do
    visit root_path
    click_on 'Login'
    click_on 'Sim, quero ser parceiro Paynow'

    expect(current_path).to eq(register_companies_path)
    expect(page).to have_content("REGISTRAR NOVO PARCEIRO")
    expect(page).to have_content('Nome Fantasia')
    expect(page).to have_content('Razão Social')
    expect(page).to have_content('CNPJ')
    expect(page).to have_content('Endereço de faturamento')
    expect(page).to have_content('Email de faturamento')
    expect(page).to have_content('Email do administrador')
    expect(page).to have_content('CONFIRMO QUE OS DADOS FORNECDOS ACIMA SÃO VERDADEIROS E AUTÊNTICOS E ESTOU DE ACORDO COM OS TERMOS DE USO. FICO CIENTE QUE A FALSIDADE DESSA DECLARAÇÃO CONFIGURA CRIME PREVISTO NO CÓDIGO PENAL BRASILEIRO PASSÍVEL DE APURAÇÃO NA FORMA DA LEI.')
    expect(page).to have_button('Registrar')


  end

  xit '- Should be able to access partner page' do
    visit root_path
    click_on 'Login'
    click_on 'Sim, sou parceiro Paynow'

  end
end