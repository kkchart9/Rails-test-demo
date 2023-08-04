class HedgehogsController < ApplicationController
  before_action :set_hedgehog, only: %i[ show edit update destroy ]

  # GET /hedgehogs or /hedgehogs.json
  def index
    @hedgehogs = Hedgehog.all
  end

  # GET /hedgehogs/1 or /hedgehogs/1.json
  def show
  end

  # GET /hedgehogs/new
  def new
    @hedgehog = Hedgehog.new
  end

  # GET /hedgehogs/1/edit
  def edit
  end

  # POST /hedgehogs or /hedgehogs.json
  def create
    @hedgehog = Hedgehog.new(hedgehog_params)

    respond_to do |format|
      if @hedgehog.save
        format.html { redirect_to hedgehog_url(@hedgehog), notice: "Hedgehog was successfully created." }
        format.json { render :show, status: :created, location: @hedgehog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hedgehog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hedgehogs/1 or /hedgehogs/1.json
  def update
    respond_to do |format|
      if @hedgehog.update(hedgehog_params)
        format.html { redirect_to hedgehog_url(@hedgehog), notice: "Hedgehog was successfully updated." }
        format.json { render :show, status: :ok, location: @hedgehog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hedgehog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hedgehogs/1 or /hedgehogs/1.json
  def destroy
    @hedgehog.destroy

    respond_to do |format|
      format.html { redirect_to hedgehogs_url, notice: "Hedgehog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hedgehog
      @hedgehog = Hedgehog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hedgehog_params
      params.require(:hedgehog).permit(:name, :age)
    end
end
