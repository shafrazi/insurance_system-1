class Customer < ApplicationRecord
  has_many :insurance_policies, dependent: :destroy, inverse_of: :customer
  accepts_nested_attributes_for :insurance_policies, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true
  validates :address, presence: true

  def self.search(query)
    where("name like ?", "%#{query}%")
    #code
  end
end
