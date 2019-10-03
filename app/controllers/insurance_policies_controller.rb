class InsurancePoliciesController < ApplicationController
  include InsurancePoliciesHelper
  before_action :set_insurance_policy, only: [:show, :edit, :update, :destroy]

  # GET /insurance_policies
  # GET /insurance_policies.json
  def index
    # @insurance_policies = InsurancePolicy.all
    # params for search field of insurance policy, if no fields are given return all policies
    if params[:search_date] == nil || params[:search_date] == ""
      @insurance_policies = InsurancePolicy.all.order("current_expiry ASC")
    else
      @insurance_policies = InsurancePolicy.search_date(Date.strptime(params[:search_date], "%m/%d/%Y").strftime("%d/%m/%Y").to_datetime).all.order("current_expiry ASC")
    end

    # if params[:search]
    #   @insurance_policies = InsurancePolicy.search(params[:search]).all.order("current_expiry ASC")
    # else
    #   @insurance_policies = InsurancePolicy.all.order("current_expiry ASC")
    # end
  end

  # GET /insurance_policies/1
  # GET /insurance_policies/1.json
  def show
    @renewals = @insurance_policy.renewals
  end

  # GET /insurance_policies/new
  def new
    @insurance_policy = InsurancePolicy.new
  end

  # GET /insurance_policies/1/edit
  def edit
  end

  # POST /insurance_policies
  # POST /insurance_policies.json
  def create
    @insurance_policy = InsurancePolicy.new(insurance_policy_params)

    respond_to do |format|
      if @insurance_policy.save
        format.html { redirect_to @insurance_policy, notice: 'Insurance policy was successfully created.' }
        format.json { render :show, status: :created, location: @insurance_policy }
      else
        format.html { render :new }
        format.json { render json: @insurance_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_policies/1
  # PATCH/PUT /insurance_policies/1.json
  def update
    respond_to do |format|
      if @insurance_policy.update(insurance_policy_params)
        if @insurance_policy.renewals.any?
          @renewal = @insurance_policy.renewals.last
          @insurance_policy.update_attributes(current_expiry: @renewal.expiry_date, policyno: @renewal.policyno)
        end
        format.html { redirect_to @insurance_policy, notice: 'Insurance policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance_policy }
      else
        format.html { render :edit }
        format.json { render json: @insurance_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_policies/1
  # DELETE /insurance_policies/1.json
  def destroy
    @insurance_policy.destroy
    respond_to do |format|
      format.html { redirect_to insurance_policies_url, notice: 'Insurance policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_policy
      @insurance_policy = InsurancePolicy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_policy_params
      params.require(:insurance_policy).permit(:policyno, :insurer, :value, :insurance_type, :current_expiry, :customer_id, renewals_attributes: [:id, :policyno, :begin_date, :expiry_date, :_destroy])
    end
end
