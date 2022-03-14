class Admin::PaymentMethodsController < Admin::AdminController
  before_action :authenticate_admin!
  before_action :set_payment_method, only: %i[edit update destroy]

  def index
    @payment_methods = PaymentMethod.all
    render '/admin/payment_methods/index', layout: 'application'
  end

  def new
    @payment_method = PaymentMethod.new
    render '/admin/payment_methods/new', layout: 'application'
  end

  def create
    @payment_method = PaymentMethod.create!(payment_method_params)

    if @payment_method
      redirect_to '/admin/payment_methods/', layout: 'application', notice: t('.success')
    else
      @payment_method = PaymentMethod.new
      render '/admin/payment_methods/new', layout: 'application', alert: t('.fail')
    end
  end

  def edit
    render '/admin/payment_methods/edit', layout: 'application'
  end

  def update
    if @payment_method.update!(update_params)
      redirect_to '/admin/payment_methods', layout: 'application', notice: t('.success')
    else
      render '/admin/payment_methods/edit', layout: 'application', alert: t('.fail')
    end
  end

  def destroy
    @payment_method.destroy
    redirect_to '/admin/payment_methods', layout: 'application', notice: t('.success')
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :payment_fee, :max_pay_fee, :payment_type, :status)
  end

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def update_params
    params.require(:payment_method).permit(:payment_fee, :max_pay_fee, :status)
  end
end
