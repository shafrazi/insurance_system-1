class Renewal < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :insurance_policy
  validates :policyno, :begin_date, :expiry_date, presence: true
  validates_with RenewalValidator

end
