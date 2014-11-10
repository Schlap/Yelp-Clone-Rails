require 'rails_helper'

describe 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: "KFC")
    kfc.reviews.create(rating: 3, thoughts: "It was an abomination")
  end

  it "a user can endorse a review, which increments the endorsement count", js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsements')
  end
end

# def review_restaurant
#       click_link 'Review KFC'
#       fill_in('Thoughts', with: 'Broth a bit thick')
#       click_button('Leave Review')
#       click_link 'Review Bone Daddies'
#       fill_in('Thoughts', with: 'Broth a bit thick')
#       click_button('Leave Review')
# end