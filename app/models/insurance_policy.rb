class InsurancePolicy < ApplicationRecord
  belongs_to :customer
  has_many :renewals, dependent: :destroy, inverse_of: :insurance_policy
  accepts_nested_attributes_for :renewals, reject_if: :all_blank, allow_destroy: true
  validates :policyno, :insurer, :value, :insurance_type, :current_expiry, :customer_id, presence: false

  def self.search(query)
    where("policyno like ?", "%#{query}%")
    #code
  end

  def self.expired
    where("current_expiry < ?", Time.now)
    #code
  end

  def self.search_date(query)
    where("current_expiry < ?", "#{query} 00:00:00")
    #code
  end

end
