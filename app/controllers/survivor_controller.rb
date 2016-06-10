class SurvivorController < ApplicationController

  before_action :set_survivor, only: [:show, :update, :destroy]
  before_action :set_ip

  # GET /survivors.json
  def index
    render json: Survivor.all, status: :ok
  end

  # GET /survivors/1.json
  def show
    if stale?(last_modified: @survivor.updated_at, public: true)
      render json: @survivor, status: :ok
    end
  end

  # POST /survivors.json
  def create
    @survivor = Survivor.new(survivor_params)
      if @survivor.save
        render json: :show, status: :created, location: @survivor
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end

  end

  # PATCH/PUT /survivors/1.json
  def update
      if @survivor.update(survivor_params)
        render json: :show, status: :ok, location: @survivor
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
  end

  # DELETE /survivors/1.json
  def destroy
    if @survivor.destroy
      render json: :index, status: :ok
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_survivor
    @survivor = Survivor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def survivor_params
    params.require(:survivor).permit(:name, :age, :gender, :lat, :lng, initial_items: {})
  end

  # set ip for geolocation definition
  def set_ip
    if request.remote_ip && @survivor
      @survivor.ip_address = request.remote_ip
      @survivor.save!
    end
  end
end

