class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :organisation_name
      t.string :contact_person
      t.string :address_line_1
      t.string :address_line_2
      t.string :town
      t.string :county
      t.string :postcode
      t.string :telephone_no
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
