class CartaoDeCreditoClientPm < ApplicationRecord
  belongs_to :payment_method
  belongs_to :company
end
