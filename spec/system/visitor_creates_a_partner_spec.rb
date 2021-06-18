require 'rails_helper'

describe 'Visitor visit no partner page' do

  it '- Should be able creates a new partner' do
    visit root_path
    click_on 'Login'
    click_on 'Sim, quero ser parceiro Paynow'

    fill_in 'Nome Fantasia', with: 'Mercado do Bairro'
    fill_in 'CNPJ', with: '12.123.123/0001-02'
    fill_in 'Razão Social', with: 'ABCD Laticínios'
    fill_in 'Endereço de faturamento', with: 'Rua Maestro Cállia - 50 - Vila Mariana - São Paulo - SP'
    fill_in 'Email de faturamento', with: 'cobranca@abcd.com.br'
    fill_in 'Email do administrador', with: 'admin@abcd.com.br'

    click_on 'Registrar'

    expect(current_path).to eq(register_clients_path)
    expect(page).to have_content("Empresa Cadastrada com sucesso, agora cadastre seus dados!")
    expect(page).to have_content("CADASTRO DE CLIENTE")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
    expect(page).to have_button("Registrar")

  end

  it '- Should be able creates a new partner and new client' do
    visit root_path
    click_on 'Login'
    click_on 'Sim, quero ser parceiro Paynow'

    fill_in 'Nome Fantasia', with: 'Mercado do Bairro'
    fill_in 'CNPJ', with: '12.123.123/0001-02'
    fill_in 'Razão Social', with: 'ABCD Laticínios'
    fill_in 'Endereço de faturamento', with: 'Rua Maestro Cállia - 50 - Vila Mariana - São Paulo - SP'
    fill_in 'Email de faturamento', with: 'cobranca@abcd.com.br'
    fill_in 'Email do administrador', with: 'admin@abcd.com.br'

    click_on 'Registrar'

    fill_in 'Email', with: 'admin@abcd.com.br'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Registrar'

    expect(current_path).to eq(new_client_session_path)
    expect(page).to have_content("Seu cadastro foi criado com sucesso faça seu login para continuar")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")

  end
end