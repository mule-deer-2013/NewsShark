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


feature 'User signin', :js => true do
  context 'with valid params' do
   let!(:user) { User.create(:email      => 'thomas@me.com',
                              :first_name => 'thomas',
                              :last_name  => 'landon',
                              :password   => '123notit',
                              :password_confirmation => '123notit')} 

    it 'displays success message' do
      visit signin_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
      expect(page).to have_content( "Welcome Back Shark" )
    end
  end

  context 'with invalid params' do
    it 'displays error message(s)' do
      visit signin_path
      fill_in "Email", :with => ''
      fill_in "Password", :with => ''
      click_button "Sign in"
      expect(page).to have_content('Invalid email/password combination')
    end
  end
end
