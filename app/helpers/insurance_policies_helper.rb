module InsurancePoliciesHelper
  def is_expired?(insurance_policy)
    insurance_policy.current_expiry < Time.now
    #code
  end
end
