class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants

  def find_plot_plant_id(plot_id)
    PlotPlant.find_by_plant_and_plot_id(self.id, plot_id)
  end
end
