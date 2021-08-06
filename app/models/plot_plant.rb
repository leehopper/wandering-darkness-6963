class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant

  def self.find_by_plant_and_plot_id(plant_id, plot_id)
    find_by(plant_id: plant_id, plot_id: plot_id)
  end
end
