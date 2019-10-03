require 'test_helper'

class RenewalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @renewal = renewals(:one)
  end

  test "should get index" do
    get renewals_url
    assert_response :success
  end

  test "should get new" do
    get new_renewal_url
    assert_response :success
  end

  test "should create renewal" do
    assert_difference('Renewal.count') do
      post renewals_url, params: { renewal: { begin_date: @renewal.begin_date, expiry_date: @renewal.expiry_date, insurance_policy_id: @renewal.insurance_policy_id, policyno: @renewal.policyno } }
    end

    assert_redirected_to renewal_url(Renewal.last)
  end

  test "should show renewal" do
    get renewal_url(@renewal)
    assert_response :success
  end

  test "should get edit" do
    get edit_renewal_url(@renewal)
    assert_response :success
  end

  test "should update renewal" do
    patch renewal_url(@renewal), params: { renewal: { begin_date: @renewal.begin_date, expiry_date: @renewal.expiry_date, insurance_policy_id: @renewal.insurance_policy_id, policyno: @renewal.policyno } }
    assert_redirected_to renewal_url(@renewal)
  end

  test "should destroy renewal" do
    assert_difference('Renewal.count', -1) do
      delete renewal_url(@renewal)
    end

    assert_redirected_to renewals_url
  end
end
