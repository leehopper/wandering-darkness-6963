require 'rails_helper'

RSpec.describe Plant do
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants) }
  end

  before(:each) do
    @garden_1 = Garden.create!(name: 'Englewood Garden', organic: true)
    @plot_1 = @garden_1.plots.create!(number: 10, size: 'Large', direction: 'North')
    @plant_1 = Plant.create!(name: 'Tomato', description: 'cherry', days_to_harvest: 90)
  end

  describe 'instance methods' do
    describe '.find_plot_plant_id' do
      it 'returns the plot plant id' do
        @plot_plant = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)

        expect(@plant_1.find_plot_plant_id(@plot_1.id).id).to eq(@plot_plant.id)
      end
    end
  end
end
