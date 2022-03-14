class Admin::AdminController < ActionController::Base
  before_action :authenticate_admin!, only: %i[index]

  def index
    render 'admin/index', layout: 'application'
  end
end
