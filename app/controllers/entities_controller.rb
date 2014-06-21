class EntitiesController < ApplicationController
  before_action :set_entity, only: [:show, :update, :destroy]

  # GET /entities
  # GET /entities.json
  def index
    @entities = Entity.all
    render json: @entities
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
    render json: @entity
  end

  # POST /entities
  # POST /entities.json
  def create
    @entity = Entity.new(entity_params)
    sleep(2.0)
    respond_to do |format|
      if @entity.save
        format.json { render json: @entity, status: :created}
      else
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entities/1
  # PATCH/PUT /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.json { head :no_content }
      else
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    @entity.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @entity = Entity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entity_params
      params.require(:entity).permit(:name, :description, :x, :y)
    end
end
