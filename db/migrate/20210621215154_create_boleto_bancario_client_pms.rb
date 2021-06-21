class CreateBoletoBancarioClientPms < ActiveRecord::Migration[6.1]
  def change
    create_table :boleto_bancario_client_pms do |t|
      t.string :bank_code
      t.string :bank_agency
      t.string :bank_account
      t.belongs_to :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
