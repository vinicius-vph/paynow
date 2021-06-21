class CreateCompanyLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :company_logs do |t|
      t.string :fantasy_name
      t.string :cnpj
      t.string :corporate_name
      t.string :billing_address
      t.string :billing_email
      t.string :company_admin_email
      t.string :company_token
      t.integer :status
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
