class CostsController < ApplicationController
  before_action :set_cost, only: %i[ show edit update destroy ]

  # GET /costs or /costs.json
  def index
    @costs = Cost.all.order(start_date: :desc)
  end

  # GET /costs/1 or /costs/1.json
  def show
  end

  # GET /costs/new
  def new
    @cost = Cost.new(start_date: Time.new.strftime("%Y-%m-%dT%k:%M"))
  end

  # GET /costs/1/edit
  def edit
  end

  # POST /costs or /costs.json
  def create
    referrer_controller = Rails.application.routes.recognize_path(request.referrer)[:controller]
    @cost = Cost.new(cost_params)
    binding.pry
    respond_to do |format|
      if @cost.save
        @costs = Cost.all.order(start_date: :desc)
        format.turbo_stream
        format.html { redirect_to cost_url(@cost), notice: "Cost was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /costs/1 or /costs/1.json
  def update
    respond_to do |format|
      if @cost.update(cost_params)
        format.turbo_stream
        format.html { redirect_to cost_url(@cost), notice: "Cost was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costs/1 or /costs/1.json
  def destroy
    @cost.destroy

    respond_to do |format|
      format.html { redirect_to costs_url, notice: "Cost was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost
      @cost = Cost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cost_params
      params.require(:cost).permit(:start_date, :amount, :currency, :user_id)
    end
end
