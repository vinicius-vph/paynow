class Client::CompaniesController < Client::ClientController
  before_action :authenticate_client!
  before_action :set_company, only: %i[show edit update update_token]
  before_action :client_admin?, only: %i[edit update update_token]

  def show
    render '/client/companies/show', layout: 'application'
  end

  def edit
    render '/client/companies/edit', layout: 'application'
  end

  def update
    if @company.update!(company_params)
      redirect_to [:client, @company], layout: 'application', notice: t('.success')
    else
      render '/client/companies/edit', layout: 'application', alert: t('.fail')
    end
  end

  def update_token
    smart_token = SecureRandom.base58(20)

    if Company.where(company_token: smart_token).any?
      redirect_to [:client, @company], layout: 'application', notice: t('.fail')
    else
      @company.company_token = smart_token
      @company.save
      redirect_to [:client, @company], layout: 'application', notice: t('.success')
    end
  end

  private

  def company_params
    params.require(:company).permit(:fantasy_name, :cnpj, :corporate_name, :billing_address, :billing_email)
  end

  def set_company
    @company = Company.find(current_client.company_id)
  end

  def client_admin?
    unless @company.company_admin_email == current_client.email
      redirect_to client_root_path, layout: 'application', alert: t('.alert')
    end
  end
end
