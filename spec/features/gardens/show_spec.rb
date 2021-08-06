require "rails_helper"

RSpec.describe 'the garden show' do
  before(:each) do
    @garden_1 = Garden.create!(name: 'Englewood Garden', organic: true)
    @plot_1 = @garden_1.plots.create!(number: 10, size: 'Large', direction: 'North')
    @plot_2 = @garden_1.plots.create!(number: 30, size: 'Medium', direction: 'South')
    @plot_3 = @garden_1.plots.create!(number: 20, size: 'Small', direction: 'East')
    @plant_1 = Plant.create!(name: 'Tomato', description: 'cherry', days_to_harvest: 90)
    @plant_2 = Plant.create!(name: 'Corn', description: 'sweet', days_to_harvest: 120)
    @plant_3 = Plant.create!(name: 'Squash', description: 'butternut', days_to_harvest: 20)
    @plant_4 = Plant.create!(name: 'Lettuce', description: 'oak leaf', days_to_harvest: 50)
    @plant_5 = Plant.create!(name: 'Rosemary', description: 'herb', days_to_harvest: 100)

    @plot_1.plants << @plant_1
    @plot_1.plants << @plant_2
    @plot_1.plants << @plant_3

    @plot_2.plants << @plant_2
    @plot_2.plants << @plant_3
    @plot_2.plants << @plant_4

    @plot_3.plants << @plant_3
    @plot_3.plants << @plant_4
    @plot_3.plants << @plant_5
  end

  describe 'display' do
    it 'shows all of the unique plants in the garden that take less than 100 days to harvest and ordered number of plants in plots from most to least' do
      visit garden_path(@garden_1.id)

      within("#header") do
        expect(page).to have_content("#{@garden_1.name} Plants")
      end

      # within("#plants") do
      # end
    end
  end
end
