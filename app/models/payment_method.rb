class PaymentMethod < ApplicationRecord
    enum status: { inativo: 0, ativo: 1 }
    enum payment_type: { pix: 0, boleto_bancario: 1, cartao_de_credito: 2  }

    validates :name, :payment_fee, :max_pay_fee, :payment_type, presence: true
    validates :name, uniqueness: true
end
