class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.decimal :payment_fee
      t.decimal :max_pay_fee
      t.integer :type
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
