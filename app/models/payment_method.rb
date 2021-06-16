class PaymentMethod < ApplicationRecord
    enum status: { inativo: 0, ativo: 1 }
    enum payment_type: { pix: 0, boleto_bancario: 1, cartao_de_credito: 2  }

    validates :name, :payment_fee, :max_pay_fee, :payment_type, presence: true
    validates :name, uniqueness: true
    validates :payment_fee, :max_pay_fee, numericality: { greater_than_or_equal_to: 0 }
end
