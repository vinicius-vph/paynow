class HomeController < ApplicationController
    def index
    end

    def register
    end

    def new_register_companies
        @company = Company.new
    end

    def create_register_companies
        @company = Company.create!(company_params)

        if @company
            redirect_to register_clients_path(id: @company, name: @company.fantasy_name, pattern: @company.company_admin_email.split('@').last), layout: "application", notice: t('.success')
        else
            @company = Company.new
            render "register/companies", layout: "application", notice: t('.fail')
        end
    end

    def new_register_clients
        @client = Client.new
    end

    def create_register_clients
        @client = Client.create!(client_params)

        if @client
            redirect_to new_client_session_path, layout: "application", notice: t('.success')
        else
            @client = Client.new
            render "register/clients", layout: "application", notice: t('.fail')
        end 
    end


    private

    def company_params
        params.require(:company).permit(:fantasy_name, :cnpj, :corporate_name, :billing_address, :billing_email, :company_admin_email)
    end

    def client_params
        params.require(:client).permit(:email, :password, :company_id)
    end

    def set_company
        @company = Company.find(params[:id])
    end
end