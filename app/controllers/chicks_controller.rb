class ChicksController < ApplicationController
  before_action :set_chick, only: %i[ show edit update destroy ]

  # GET /chicks or /chicks.json
  def index
    @chicks = Chick.all
  end

  # GET /chicks/1 or /chicks/1.json
  def show
  end

  # GET /chicks/new
  def new
    @chick = Chick.new
  end

  # GET /chicks/1/edit
  def edit
  end

  # POST /chicks or /chicks.json
  def create
    @chick = Chick.new(chick_params)

    respond_to do |format|
      if @chick.save
        format.html { redirect_to chick_url(@chick), notice: "Chick was successfully created." }
        format.json { render :show, status: :created, location: @chick }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chick.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chicks/1 or /chicks/1.json
  def update
    respond_to do |format|
      if @chick.update(chick_params)
        format.html { redirect_to chick_url(@chick), notice: "Chick was successfully updated." }
        format.json { render :show, status: :ok, location: @chick }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chick.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chicks/1 or /chicks/1.json
  def destroy
    @chick.destroy

    respond_to do |format|
      format.html { redirect_to chicks_url, notice: "Chick was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chick
      @chick = Chick.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chick_params
      params.require(:chick).permit(:name, :age)
    end
end
