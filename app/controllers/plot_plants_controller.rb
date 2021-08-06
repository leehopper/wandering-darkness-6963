class PlotPlantsController < ApplicationController
  def destroy
    PlotPlant.find(params[:id]).destroy
    redirect_to plots_path
  end
end
