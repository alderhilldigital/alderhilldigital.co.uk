class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :course_date, index: true, foreign_key: true
      t.string :stripe_charge_id
      t.string :name
      t.string :email
      t.string :telephone
      t.string :address_line1
      t.string :address_line2
      t.string :town
      t.string :county
      t.string :postcode
      t.string :country
      t.boolean :paid

      t.timestamps null: false
    end
  end
end
