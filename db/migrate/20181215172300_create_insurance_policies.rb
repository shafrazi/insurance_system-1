class CreateInsurancePolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :insurance_policies do |t|
      t.string :policyno
      t.string :insurer
      t.decimal :value
      t.string :insurance_type
      t.date :current_expiry
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
