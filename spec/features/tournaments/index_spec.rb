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

end
