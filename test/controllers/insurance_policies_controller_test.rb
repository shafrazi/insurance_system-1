require 'test_helper'

class InsurancePoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @insurance_policy = insurance_policies(:one)
  end

  test "should get index" do
    get insurance_policies_url
    assert_response :success
  end

  test "should get new" do
    get new_insurance_policy_url
    assert_response :success
  end

  test "should create insurance_policy" do
    assert_difference('InsurancePolicy.count') do
      post insurance_policies_url, params: { insurance_policy: { current_expiry: @insurance_policy.current_expiry, customer_id: @insurance_policy.customer_id, insurance_type: @insurance_policy.insurance_type, insurer: @insurance_policy.insurer, policyno: @insurance_policy.policyno, value: @insurance_policy.value } }
    end

    assert_redirected_to insurance_policy_url(InsurancePolicy.last)
  end

  test "should show insurance_policy" do
    get insurance_policy_url(@insurance_policy)
    assert_response :success
  end

  test "should get edit" do
    get edit_insurance_policy_url(@insurance_policy)
    assert_response :success
  end

  test "should update insurance_policy" do
    patch insurance_policy_url(@insurance_policy), params: { insurance_policy: { current_expiry: @insurance_policy.current_expiry, customer_id: @insurance_policy.customer_id, insurance_type: @insurance_policy.insurance_type, insurer: @insurance_policy.insurer, policyno: @insurance_policy.policyno, value: @insurance_policy.value } }
    assert_redirected_to insurance_policy_url(@insurance_policy)
  end

  test "should destroy insurance_policy" do
    assert_difference('InsurancePolicy.count', -1) do
      delete insurance_policy_url(@insurance_policy)
    end

    assert_redirected_to insurance_policies_url
  end
end
