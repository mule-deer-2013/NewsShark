require 'spec_helper'

feature "User signup", :js => true do
  context "with valid params" do
    it "displays success message" do
      visit new_user_path
      fill_in "First name", :with => "news"
      fill_in "Last name", :with => "shark"
      fill_in "Email", :with => "news@shark.com"
      fill_in "Password", :with => "newsshark"
      fill_in "Password confirmation", :with => "newsshark"
      click_button "Sign up"
      expect(page).to have_content( "Welcome!" )
    end
  end
  it "displays error message(s)" do
    visit new_user_path
    fill_in "First name", :with => ""
    fill_in "Last name", :with => ""
    fill_in "Email", :with => ""
    fill_in "Password", :with => ""
    fill_in "Password confirmation", :with => ""
    click_button "Sign up"
    expect(page).to have_content( "can't be blank" )
  end
end
