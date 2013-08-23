require 'spec_helper'

describe "Static pages" do

	subject { page }

	describe "Home page" do
		before { visit root_path }
		it { should have_selector('h1', text: 'Home') }
    it { should have_selector('title', text: full_title('') ) }
    it { should_not have_selector 'title', text: '| Home'}
	end

	describe "About page" do
		before { visit about_path}
		it { should have_selector('h1', text: 'About') }
		it { should have_selector('title', text: full_title('About') ) }	
	end

	describe "Contact page" do
		before { visit contact_path}
		it { should have_selector('h1', text: 'Contact') }
		it { should have_selector('title', text: full_title('Contact') ) }	
	end

	describe "Master page" do
		before { visit master_path}
		it { should have_selector('h1', text: 'Master Data') }
		it { should have_selector('title', text: full_title('Master Data') ) }	
	end	
end