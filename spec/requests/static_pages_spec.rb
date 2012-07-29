require 'spec_helper'
describe "StaticPages" do
	describe "Home page" do
		it "should have the h1 'NGS App'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'NGS App')
		end
		it "should have the right title" do
			visit '/static_pages/home'
			page.should have_selector('title', :text => "NGS App | Home")
		end	
	end
	describe "Help page" do
		it "should have the h1 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => 'Help')
		end
		it "should have the right title" do
			visit '/static_pages/help'
			page.should have_selector('title', :text => "NGS App | Help")
		end
	end
	describe "About page" do
		it "should have the h1 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('h1', :text => 'About Us')
		end
		it "should have the right title" do
			visit '/static_pages/about'
			page.should have_selector('title', :text => "NGS App | About Us")
		end
	end
		describe "Contact page" do
		it "should have the h1 'Contact'" do
			visit '/static_pages/contact'
			page.should have_selector('h1', :text => 'Contact')
		end
		it "should have the right title" do
			visit '/static_pages/contact'
			page.should have_selector('title', :text => "NGS App | Contact")
		end
	end
end
