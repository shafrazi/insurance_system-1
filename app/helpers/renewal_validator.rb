class RenewalValidator < ActiveModel::Validator
  def validate(record)
    insurance_policy = record.insurance_policy
    unless record.expiry_date > insurance_policy.current_expiry
      record.errors[:current_expiry] << "needs to be a date later than current policy expiry date"
    end
  end
end
