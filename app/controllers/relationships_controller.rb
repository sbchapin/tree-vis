class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:show, :update, :destroy]

  # GET /relationships
  # GET /relationships.json
  def index
    @relationships = Relationship.all
    render json: @relationships
  end

  # GET /relationships/1
  # GET /relationships/1.json
  def show
    render json: @relationship
  end

  # POST /relationships
  # POST /relationships.json
  def create
    @relationship = Relationship.new(relationship_params)

    respond_to do |format|
      if @relationship.save
        format.json { render json: @relationship, status: :created}
      else
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    respond_to do |format|
      if @relationship.update(relationship_params)
        format.json { head :no_content }
      else
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationship.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.require(:relationship).permit(:entity_source_id, :entity_target_id)
    end
end
