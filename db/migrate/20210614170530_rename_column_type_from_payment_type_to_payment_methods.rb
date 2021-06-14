class RenameColumnTypeFromPaymentTypeToPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    rename_column :payment_methods, :type, :payment_type
  end
end
