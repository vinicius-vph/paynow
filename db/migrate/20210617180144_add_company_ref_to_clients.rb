class AddCompanyRefToClients < ActiveRecord::Migration[6.1]
  def change
    add_reference :clients, :company, null: false, foreign_key: true
  end
end