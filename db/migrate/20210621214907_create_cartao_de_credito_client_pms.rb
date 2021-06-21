class CreateCartaoDeCreditoClientPms < ActiveRecord::Migration[6.1]
  def change
    create_table :cartao_de_credito_client_pms do |t|
      t.string :card_code
      t.belongs_to :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
