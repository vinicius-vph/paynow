class Admin::CompaniesController < Admin::AdminController
    before_action :authenticate_admin!
    before_action :set_company, only: %i[show edit update update_token]

    def index
        @companies = Company.all
        render "/admin/companies/index", layout: "application"
    end

    def show
        render "/admin/companies/show", layout: "application"
    end 

    def edit
        render "/admin/companies/edit", layout: "application"
    end

    def update
        if @company.update!(company_params)
            redirect_to [:admin, @company], layout: "application", notice: t('.success')
        else
            render "/admin/companies/edit", layout: "application"
        end   
    end

    def update_token
        smartToken = SecureRandom.base58(20)

        unless Company.where(company_token: smartToken).any?
            @company.company_token = smartToken    
            @company.save
            redirect_to [:admin, @company], layout: "application", notice: t('.success')
        else
            redirect_to [:admin, @company], layout: "application", notice: t('.fail')
        end
    end

    private

    def company_params
        params.require(:company).permit(:fantasy_name, :cnpj, :corporate_name, :billing_address, :billing_email, :company_admin_email, :company_token, :status)
    end

    def set_company
        @company = Company.find(params[:id])
    end
end