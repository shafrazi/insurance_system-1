class RenewalsController < ApplicationController
  before_action :set_renewal, only: [:show, :edit, :update, :destroy]

  # GET /renewals
  # GET /renewals.json
  def index
    @renewals = Renewal.all
  end

  # GET /renewals/1
  # GET /renewals/1.json
  def show
  end

  # GET /renewals/new
  def new
    @renewal = Renewal.new
  end

  # GET /renewals/1/edit
  def edit
  end

  # POST /renewals
  # POST /renewals.json
  def create
    @renewal = Renewal.new(renewal_params)

    respond_to do |format|
      if @renewal.save
        format.html { redirect_to insurance_policy_path(@renewal.insurance_policy), notice: 'Renewal was successfully created.' }
        format.json { render :show, status: :created, location: @renewal }
        # for each new renewal added parent policy expiry and policy no will change to match current renewal
        @insurance_policy = @renewal.insurance_policy
        @insurance_policy.update_attributes(current_expiry: @renewal.expiry_date, policyno: @renewal.policyno)
      else
        format.html { render :new }
        format.json { render json: @renewal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /renewals/1
  # PATCH/PUT /renewals/1.json
  def update
    @insurance_policy = @renewal.insurance_policy
    respond_to do |format|
      if @renewal.update(renewal_params)
        format.html { redirect_to @renewal, notice: 'Renewal was successfully updated.' }
        format.json { render :show, status: :ok, location: @renewal }
        # update policy no and expiry of parent policy only if current renewal is the latest renewal
        if @renewal == @insurance_policy.renewals.last
          @insurance_policy.update_attributes(current_expiry: @renewal.expiry_date, policyno: @renewal.policyno)
        end
      else
        format.html { render :edit }
        format.json { render json: @renewal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /renewals/1
  # DELETE /renewals/1.json
  def destroy
    @insurance_policy = @renewal.insurance_policy
      # update parent policy's attributes to match the next latest renewal only if current renewal is the latest and not the only renewal
      if @renewal == @insurance_policy.renewals.last && @renewal!= @insurance_policy.renewals.first
      @renewal.destroy
        respond_to do |format|
          format.html { redirect_to insurance_policy_path(@insurance_policy), notice: 'Renewal was successfully destroyed.' }
          format.json { head :no_content }
        end
      @insurance_policy.update_attributes(current_expiry: @insurance_policy.renewals.last.expiry_date, policyno: @insurance_policy.renewals.last.policyno)
      else
        @renewal.destroy
        respond_to do |format|
          format.html { redirect_to insurance_policy_path(@insurance_policy), notice: 'Renewal was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
  end

  def policy_index_renew
    @renewal = Renewal.new
    @insurance_policy = InsurancePolicy.find(params[:insurance_policy_id])
    #code
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_renewal
      @renewal = Renewal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def renewal_params
      params.require(:renewal).permit(:policyno, :begin_date, :expiry_date, :insurance_policy_id)
    end
end
