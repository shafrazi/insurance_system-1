class CreateRenewals < ActiveRecord::Migration[5.0]
  def change
    create_table :renewals do |t|
      t.string :policyno
      t.date :begin_date
      t.date :expiry_date
      t.references :insurance_policy, foreign_key: true

      t.timestamps
    end
  end
end
