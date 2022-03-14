class Client::ClientController < ActionController::Base
  before_action :authenticate_client!, only: %i[index]
  before_action :set_company, only: %i[index]

  def index
    render 'client/index', layout: 'application'
  end

  private

  def set_company
    @company = Company.find(current_client.company_id)
  end
end
