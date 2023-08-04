class OwlsController < ApplicationController
  before_action :set_owl, only: %i[ show edit update destroy ]

  # GET /owls or /owls.json
  def index
    @owls = Owl.all
  end

  # GET /owls/1 or /owls/1.json
  def show
  end

  # GET /owls/new
  def new
    @owl = Owl.new
  end

  # GET /owls/1/edit
  def edit
  end

  # POST /owls or /owls.json
  def create
    @owl = Owl.new(owl_params)

    respond_to do |format|
      if @owl.save
        format.html { redirect_to owl_url(@owl), notice: "Owl was successfully created." }
        format.json { render :show, status: :created, location: @owl }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @owl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owls/1 or /owls/1.json
  def update
    respond_to do |format|
      if @owl.update(owl_params)
        format.html { redirect_to owl_url(@owl), notice: "Owl was successfully updated." }
        format.json { render :show, status: :ok, location: @owl }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @owl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owls/1 or /owls/1.json
  def destroy
    @owl.destroy

    respond_to do |format|
      format.html { redirect_to owls_url, notice: "Owl was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owl
      @owl = Owl.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def owl_params
      params.require(:owl).permit(:name, :age)
    end
end
