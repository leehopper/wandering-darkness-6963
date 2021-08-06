require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plot) }
    it { should belong_to(:plant) }
  end

  before(:each) do
    @garden_1 = Garden.create!(name: 'Englewood Garden', organic: true)
    @plot_1 = @garden_1.plots.create!(number: 10, size: 'Large', direction: 'North')
    @plant_1 = Plant.create!(name: 'Tomato', description: 'cherry', days_to_harvest: 90)
    @plot_plant = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
  end

  describe 'class methods' do
    describe '#find_by_plant_and_plot_id' do
      it 'returns the plot plant id' do
        expect(PlotPlant.find_by_plant_and_plot_id(@plant_1.id, @plot_1.id).id).to eq(@plot_plant.id)
      end
    end
  end
end
