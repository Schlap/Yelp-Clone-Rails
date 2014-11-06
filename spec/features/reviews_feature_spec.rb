require 'rails_helper'

describe 'reviewing' do
  before do
    Restaurant.create(name: 'KFC')
  end

  it 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'so so'
    select "3", from: "Rating"
    click_button "Leave Review"
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  it 'displays an average rating for all reviews' do
    leave_review('So so', "3")
    new_user
    leave_review('Great', "5")
    expect(page).to have_content("Average rating: 4")
  end
end



describe 'reviewing restaurants' do
  before do
    Restaurant.create(:name => 'Bone Daddies')
  end

  context 'more than once' do
    it 'user tries to review the same restaurant more than once' do
      new_user
      click_link 'Review Bone Daddies'
      fill_in('Thoughts', with: 'Broth a bit thick')
      click_button('Leave Review')
      click_link 'Review Bone Daddies'
      fill_in('Thoughts', with: 'Broth a bit thick')
      click_button('Leave Review')
      expect(page).to have_content 'Sorry, you have already reviewed this restaurant'
    end
  end
end

  def leave_review(thoughts, rating)
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: thoughts
      select rating, from: 'Rating'
      click_button 'Leave Review'
  end

  def new_user
      User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      visit '/users/sign_in'
      fill_in('Email', with: 'test@test.com')
      fill_in('Password', with: '12345678')
      click_button('Log in')
  end
