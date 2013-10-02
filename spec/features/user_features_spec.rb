require 'spec_helper'

feature 'user signup', :js => true do
  context "with valid params" do
    it "displays success message" do
      visit new_user_path
      fill_in "First name", :with => "news"
      fill_in "Last name", :with => "shark"
      fill_in "user_email", :with => "news@shark.com"
      fill_in "user_password", :with => "newsshark"
      fill_in "Password confirmation", :with => "newsshark"
      click_button "Sign up"
      expect(page).to have_content( "Welcome!" )
    end
  end
  it 'displays error message(s)' do
    visit new_user_path
    fill_in "First name", :with => ""
    fill_in "Last name", :with => ""
    fill_in "user_email", :with => ""
    fill_in "user_password", :with => ""
    fill_in "Password confirmation", :with => ""
    click_button "Sign up"
    expect(page).to have_content( "can't be blank" )
  end
end


feature 'user signin', :js => true do
  context 'with valid params' do
    let(:user) { FactoryGirl.create(:user) }

    it 'displays success message' do
      visit new_user_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
      expect(page).to have_content( "Welcome Back Shark" )
    end
  end

  context 'with invalid params' do
    it 'displays error message(s)' do
      visit new_user_path
      fill_in "Email", :with => ''
      fill_in "Password", :with => ''
      click_button "Sign in"
      expect(page).to have_content('Invalid email/password combination')
    end
  end
end

feature 'user authentication', :js => true do
  it 'redirects to sign in page' do
    visit user_path(1)
    expect(page).to_not have_content("Welcome")
  end
end

feature 'User signout', :js => true do
  let(:user) { FactoryGirl.create(:user) }

  it 'displays sign out message' do
    visit new_user_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button 'Sign in'
    click_button 'Sign out'
    expect(page).to have_content("You have successfully logged out.")
  end
end
