require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "register page" do
		before { visit new_user_registration_path }

		it { should have_selector('h1', text: 'Sign up') }
		it { should have_selector('title', text: full_title('Sign up') ) }
	end

end
