class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def sorted_plants
    plants.where('days_to_harvest < ?', 100)
          .select('plants.*, count(plants.id) as plant_count')
          .group(:id)
          .order(plant_count: :desc)
  end
end
