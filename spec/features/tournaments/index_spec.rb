require 'spec_helper'
# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website

feature 'Root' do

  scenario 'visit the index' do
    visit tournaments_path
    expect(page).to have_content 'List of tournaments. Finished and ongoing.'
  end

  scenario 'visit the root (same as index, but different path)' do
    visit root_path
    expect(page).to have_content 'List of tournaments. Finished and ongoing.'
  end

   
    
  scenario "visit new tournament page" do  
    visit new_tournament_path
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Max round number'
    expect(page).to have_content 'Hours per round'
  end

  scenario 'adding another player to a new tournament' do
    visit root_path
    expect(page).not_to have_content 'Test Name'
    visit new_tournament_path
    fill_in 'Name', with: 'Test Name'
    fill_in 'Max round number', with: 4
    click_button 'Create Tournament'
    visit root_path
    expect(page).to have_content 'Test Name'
  end

  scenario 'adding players to a new tournament' do
    test_tournament = FactoryGirl.create(:tournament)
    visit tournament_path(test_tournament)
    expect(page).not_to have_content 'Test Name'
    expect(page).not_to have_content 'Test Surname'
    fill_in 'Name', with: 'Test Name'
    fill_in 'Surname', with: 'Test Surname'
    click_button 'Create Player'
    expect(page).to have_content 'Test Name'
    expect(page).to have_content 'Test Surname'
  end 

  scenario 'checking for validity of tournament start button' do
    test_tournament = FactoryGirl.create(:tournament)
    FactoryGirl.create(:player)
    FactoryGirl.create(:player)
    FactoryGirl.create(:player)
    FactoryGirl.create(:player)
    FactoryGirl.create(:player)
    visit root_path
    expect(page).to have_content 'not started yet'
    click_link('Show')
    click_link('Start')
    expect(page).to have_content 'Round number 1'
    visit root_path
    expect(page).to have_content 'ongoing'
  end
  scenario 'Checking for validity of standings button' do
    test_tournament = FactoryGirl.create(:tournament, max_round_number: 4)
    FactoryGirl.create(:player, tournament_id: test_tournament.id, victory_points_sum: 20)
    FactoryGirl.create(:player, tournament_id: test_tournament.id, )
    visit tournament_path(test_tournament)
    click_link('Start')
    expect(page).to have_content Player.first.name
    click_link("Show standings")
    # same as visit players_path(tournament_id: test_tournament.id)
    expect(page).to have_content "1 #{Player.first.name} #{Player.first.surname} #{Player.first.victory_points_sum}"
    expect(page).not_to have_content "2 #{Player.first.name} #{Player.first.surname} #{Player.first.victory_points_sum}"
  end
end
