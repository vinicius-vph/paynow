class PaymentMethod < ApplicationRecord
    enum status: { disabled: 0, activated: 1 }
    enum type: { pix: 0, boleto: 1, cartao: 2  }
end
