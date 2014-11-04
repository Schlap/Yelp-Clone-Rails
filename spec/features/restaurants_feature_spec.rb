require 'rails_helper'

describe 'restaurants' do

  context 'no restaurants have been added' do

    it 'should display a prompt to add a restaurant' do
      User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      visit '/users/sign_in'
      fill_in('Email', with: 'test@test.com')
      fill_in('Password', with: '12345678')
      click_button('Log in')
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

describe 'creating restaurants' do
  it 'prompts users to fill out a form' do
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/sign_in'
    fill_in('Email', with: 'test@test.com')
    fill_in('Password', with: '12345678')
    click_button('Log in')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/restaurants'
  end
end

context 'viewing restaurants' do

  before do
    @kfc = Restaurant.create(name:'KFC')
  end

  it 'lets a user view a restaurant' do
    visit '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq "/restaurants/#{@kfc.id}"
  end
end

context 'editing restaurants' do

  before do
    Restaurant.create(name: 'KFC')
  end

  it 'doesnt let a user edit a restaurant if not created by user' do
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/sign_in'
    fill_in('Email', with: 'test@test.com')
    fill_in('Password', with: '12345678')
    click_button('Log in')
    expect(page).not_to have_content 'Edit KFC'
  end

  it 'lets a user edit a restaurant only when they have created it' do
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/sign_in'
    fill_in('Email', with: 'test@test.com')
    fill_in('Password', with: '12345678')
    click_button 'Log in'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Hakisan'
    click_button 'Create Restaurant'
    expect(page).to have_content ('Edit Hakisan')
  end
end

describe 'deleting restaurants' do

  before do
    Restaurant.create(:name => "KFC")
  end

  it 'removes restaurant user creates restaurant and clicks delete link' do
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/sign_in'
    fill_in('Email', with: 'test@test.com')
    fill_in('Password', with: '12345678')
    click_button('Log in')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'McDonalds'
    click_button 'Create Restaurant'
    expect(page).to have_content 'Delete McDonalds'
  end

  it 'cannot delete restaurant when belongs to another user' do
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/sign_in'
    fill_in('Email', with: 'test@test.com')
    fill_in('Password', with: '12345678')
    click_button('Log in')
    expect(page).not_to have_content 'Delete KFC'
  end
end

describe 'creating restaurants' do


  context 'an invalid restaurant' do
    it 'does not let you submit a restaurant that is too short' do
      User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      visit '/users/sign_in'
      fill_in('Email', with: 'test@test.com')
      fill_in('Password', with: '12345678')
      click_button('Log in')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
end

describe 'creating restaurants' do
  it 'when a user is not signed in' do
    visit '/restaurants'
    expect(page).not_to have_content 'Add a restaurant'
  end
end

















