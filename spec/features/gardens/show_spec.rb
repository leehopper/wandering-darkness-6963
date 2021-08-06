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
    it 'shows unique plants in the garden in descending order by number of times in plots' do
      visit garden_path(@garden_1.id)

      within("#header") do
        expect(page).to have_content("#{@garden_1.name} Plants")
      end

      within("#plants") do
        first = find("#plant-#{@plant_3.id}")
        second = find("#plant-#{@plant_4.id}")
        third = find("#plant-#{@plant_1.id}")

        expect(first).to appear_before(second)
        expect(second).to appear_before(third)

        within("#plant-#{@plant_3.id}") do
          expect(page).to have_content("1. #{@plant_3.name}")
        end

        within("#plant-#{@plant_4.id}") do
          expect(page).to have_content("2. #{@plant_4.name}")
        end

        within("#plant-#{@plant_1.id}") do
          expect(page).to have_content("3. #{@plant_1.name}")
        end
      end
    end

    it 'does not display plants in another garden or plants with 100 or more days to harvest' do
      garden_2 = Garden.create!(name: 'Denver Garden', organic: true)
      plot_4 = garden_2.plots.create!(number: 10, size: 'Large', direction: 'North')
      plant_6 = plot_4.plants.create!(name: 'Mint', description: 'spearmint', days_to_harvest: 20)

      visit garden_path(@garden_1.id)

      expect(page).to_not have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_5.name)
      expect(page).to_not have_content(plant_6.name)
      expect(page).to_not have_content(garden_2.name)
    end
  end
end
