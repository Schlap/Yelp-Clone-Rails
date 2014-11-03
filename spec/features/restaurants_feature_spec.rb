require 'rails_helper'

describe 'restaurants' do
  context 'no restaurants have been added' do

    it 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end

context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'KFC')
  end

  it 'should display restuarant' do
    visit '/restaurants'
    expect(page).to have_content 'KFC'
    expect(page).to_not have_content ('No restaurants yet')
  end
end