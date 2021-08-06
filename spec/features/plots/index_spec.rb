require "rails_helper"

RSpec.describe 'the plot index' do
  before(:each) do
    @garden_1 = Garden.create!(name: 'Englewood Garden', organic: true)
    @plot_1 = @garden_1.plots.create!(number: 10, size: 'Large', direction: 'North')
    @plot_2 = @garden_1.plots.create!(number: 30, size: 'Medium', direction: 'South')
    @plot_3 = @garden_1.plots.create!(number: 20, size: 'Small', direction: 'East')
    @plant_1 = Plant.create!(name: 'Tomato', description: 'cherry', days_to_harvest: 90)
    @plant_2 = Plant.create!(name: 'Corn', description: 'sweet', days_to_harvest: 120)
    @plant_3 = Plant.create!(name: 'Squash', description: 'butternut', days_to_harvest: 100)
    @plant_4 = Plant.create!(name: 'Lettuce', description: 'oak leaf', days_to_harvest: 20)
    @plant_5 = Plant.create!(name: 'Rosemary', description: 'herb', days_to_harvest: 50)

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
    it 'lists all plots by number with the name of the plots plants below' do
      visit plots_path

      within("#header") do
        expect(page).to have_content("The Plot Index")
      end

      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content("Plot Number: #{@plot_1.number}")
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_button("Delete #{@plant_1.name}")
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_button("Delete #{@plant_2.name}")
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_button("Delete #{@plant_3.name}")

        expect(page).to_not have_content(@plant_4.name)
        expect(page).to_not have_content(@plant_5.name)
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content("Plot Number: #{@plot_2.number}")
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_button("Delete #{@plant_2.name}")
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_button("Delete #{@plant_3.name}")
        expect(page).to have_content(@plant_4.name)
        expect(page).to have_button("Delete #{@plant_4.name}")

        expect(page).to_not have_content(@plant_1.name)
        expect(page).to_not have_content(@plant_5.name)
      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content("Plot Number: #{@plot_3.number}")
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_button("Delete #{@plant_3.name}")
        expect(page).to have_content(@plant_4.name)
        expect(page).to have_button("Delete #{@plant_4.name}")
        expect(page).to have_content(@plant_5.name)
        expect(page).to have_button("Delete #{@plant_5.name}")

        expect(page).to_not have_content(@plant_1.name)
        expect(page).to_not have_content(@plant_2.name)
      end
    end
  end

  describe 'hyperlinks' do
    it 'removes the plant from the plot and not other plots when delete button is clicked' do
      visit plots_path
      save_and_open_page

      within("#plot-#{@plot_1.id}") do
        click_button("Delete #{@plant_3.name}")
      end

      expect(current_path).to eq(plots_path)
      save_and_open_page

      within("#plot-#{@plot_1.id}") do
        expect(page).to_not have_content(@plant_3.name)
        expect(page).to_not have_button("Delete #{@plant_3.name}")

        expect(page).to have_content("Plot Number: #{@plot_1.number}")
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_button("Delete #{@plant_2.name}")
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_button("Delete #{@plant_3.name}")
      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_button("Delete #{@plant_3.name}")
        expect(page).to have_button("Delete #{@plant_3.name}")
      end
    end
  end
end
