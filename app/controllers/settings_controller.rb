class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :update, :destroy]

  # GET /settings/1
  # GET /settings/1.json
  def index
    @settings = Setting.all
    if @settings.blank?
      @settings = [Setting.create()]
    end
    render json: @settings
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    if @setting.update(setting_params)
      head :no_content
    else
      render json: @setting.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:bezier_max_curve, :bezier_curvature, :default_height, :default_width, :zoom)
    end
end
