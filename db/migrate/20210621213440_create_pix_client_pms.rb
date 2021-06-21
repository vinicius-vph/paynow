class CreatePixClientPms < ActiveRecord::Migration[6.1]
  def change
    create_table :pix_client_pms do |t|
      t.string :key
      t.string :bank_code
      t.belongs_to :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
