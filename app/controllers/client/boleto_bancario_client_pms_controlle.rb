class Client::BoletoBancarioClientPmsController < Client::ClientController
    before_action :authenticate_client!
    # before_action :set_payment_method, only: %i[edit update destroy]

    # def index
    #     @payment_methods = PaymentMethod.where(status: :ativo).sort 
    #     render "/client/payment_methods/index", layout: "application"
    # end

    def new
        render "/client/boleto_bancario_client_pms/new", layout: "application"
    end
end
