# Commantline actions to set-up Ruby on Rails 3 App using MySql
# author: Annerose Berndt
# date: 7/29/2012

# To create a new Rails project using Git as the source control

	mkdir my_app
	cd my_app
	git init
	rails new . --git --database=mysql --skip-test-unit

# configure database.yml 
# configure Gemfile

# Install gem

	bundle install

# Install rspec
	rails generate rspec:install

# configure .gitignore

	add .DS_Store

# git

	git add .
	git commit -m "Initial commit"

	# generate new repository on github
	# paste in two lines of code that look like this:
		# git remote add origin https://github.com/berndtan/ngs_add.git
		# git push -u origin master

# deploy

	heroku create --stack cedar
	git push heroku master
	heroku open

# change README.rdoc to README.md 
	git mv README.rdoc README.md
	sublime README.md
	git status
	git commint -am "Improve the README"

# Make static pages
	git checkout -b static-pages
	rails generate controller StaticPages home help --no-test-framework
	git status
	# open routes.rb
	# open home.html.erb
	# open static_pages_controller.rb

	git add .
	git commit -m "Add a StaticPages controller"

	rails generate integration_test static_pages
	
	# in static_pages_spec.rb
		require 'spec_helper'
			describe "StaticPages" do
				describe "Home page" do
					it "should have the h1 'NGS App'" do
						visit '/static_pages/home'
						page.should have_h1('NGS App')
					end
				end
			end

	# in home.html.erb
		<h1>NGS App</h1>
		<p>This is the home page.</p>

	# test static_pages_spec.rb
	bundle exec rspec spec/ #good

	# in static_pages_spec.rb
		require 'spec_helper'
			describe "StaticPages" do
				describe "Home page" do
					it "should have the h1 'NGS App'" do
						visit '/static_pages/home'
						page.should have_h1('NGS App')
					end
				end
				describe "Help page" do
					it "should have the h1 'Help'" do
						visit '/static_pages/help'
						page.should have_h1('Help')
					end
				end
			end

	# in help.html.erb
		<h1>Help</h1>
		<p>This is the Help page.</p>

	# test static_pages_spec.rb
	bundle exec rspec spec/ #good

	#add an About page
		# in static_pages_spec.rb
		require 'spec_helper'
		describe "StaticPages" do
			describe "Home page" do
				it "should have the h1 'NGS App'" do
					visit '/static_pages/home'
					page.should have_h1('NGS App')
				end
			end
			describe "Help page" do
				it "should have the h1 'Help'" do
					visit '/static_pages/help'
					page.should have_h1('Help')
				end
			end
			describe "About page" do
				it "should have the h1 'About Us'" do
					visit '/static_pages/about'
					page.should have_h1('About Us')
				end
			end
		end

		# in routes.rb
		NgsApp::Application.routes.draw do
		  get "static_pages/home"
		  get "static_pages/help"
		  get "static_pages/about"
		end

		# in static_pages_controller.rb
		class StaticPagesController < ApplicationController
			def home
			end

			def help
			end

			def about
			end
		end

		# make new about.html.erd and add
		<h1>About Us</h1>
		<p>This is the about page.</p>

	# test static_pages_spec.rb
	bundle exec rspec spec/ #good

	# add automation to change title for each page
		# in static_pages_spec.rb
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
		end

		mv app/views/layouts/application.html.erb foobar

		# in home.html.erb
		<% provide(:title, 'Home') %>
		<!DOCTYPE html>
		<html>
		<head>
			<title>NGS App | <%= yield(:title) %></title>
		</head>
		<body>
		<h1>NGS App</h1>
		<p>This is the home page.</p>
		</body>
		</html>

		# in about.html.erb
		<% provide(:title, 'About Us') %>
		<!DOCTYPE html>
		<html>
		<head>
			<title>NGS App | <%= yield(:title) %></title>
		</head>
		<body>
		<h1>About Us</h1>
		<p>This is the about page.</p>
		</body>
		</html>

		# in help.html.erb
		<% provide(:title, 'Help') %>
		<!DOCTYPE html>
		<html>
		<head>
			<title>NGS App | <%= yield(:title) %></title>
		</head>
		<body>
		<h1>Help</h1>
		<p>This is the Help page.</p>
		</body>
		</html>

		# test static_pages_spec.rb
		bundle exec rspec spec/ #good

		mv foobar app/views/layouts/application.html.erb 

		# in application.html.erb
		<!DOCTYPE html>
		<html>
			<head>
				<title>NGS App | <%= yield(:title) %></title>
				<%= stylesheet_link_tag    "application", :media => "all" %>
				<%= javascript_include_tag "application" %>
				<%= csrf_meta_tags %>
			</head>
			<body>
				<%= yield %>
			</body>
		</html>

		# in home.html.erb
		<% provide(:title, 'Home') %>
		<h1>NGS App</h1>
		<p>This is the home page.</p>

		# in about.html.erb
		<% provide(:title, 'About Us') %>
		<h1>About Us</h1>
		<p>This is the about page.</p>

		# in help.html.erb
		<% provide(:title, 'Help') %>
		<h1>Help</h1>
		<p>This is the Help page.</p>

	# test static_pages_spec.rb
	bundle exec rspec spec/ #good

	# add a Contact page
		# in static_pages_spec.rb
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

		# in routes.rb
		NgsApp::Application.routes.draw do
		  get "static_pages/home"
		  get "static_pages/help"
		  get "static_pages/about"
		  get "static_pages/contact"
		end

		# in static_pages_controller.rb
		class StaticPagesController < ApplicationController
		  def home
		  end

		  def help
		  end

		  def about
		  end

		  def contcat
		  end
		end

		# make new contact.html.erd and add
		<% provide(:title, 'Contact') %>
		<h1>Help</h1>
		<p>This is the Contct page.</p>

	# test static_pages_spec.rb
	bundle exec rspec spec/ #good

	git status
	git add .
	git commit -m "Finish static pages"
	git checkout master
	git merge static-pages
	git push
	git push heroku
	heroku open

# make an ApplicationHelper
	# application_helper.rb
	module ApplicationHelper
		# Return the full title on a per-page status.
		def full_title(page_title)
			base_title = 'NGS App'
			if page_title.empty?
				base_title
			else
					"#{base_title} | #{page_title}"
			end
		end
	end

	# in application.html.erb
	<!DOCTYPE html>
	<html>
		<head>
			<title><%= full_title(yield(:title)) %></title>
			<%= stylesheet_link_tag    "application", :media => "all" %>
			<%= javascript_include_tag "application" %>
			<%= csrf_meta_tags %>
		</head>
		<body>
			<%= yield %>
		</body>
	</html>

	# in static_pages_spec.rb
	require 'spec_helper'
	describe "StaticPages" do
		describe "Home page" do
			it "should have the h1 'NGS App'" do
				visit '/static_pages/home'
				page.should have_selector('h1', :text => 'NGS App')
			end
			it "should have the base title" do
				visit '/static_pages/home'
				page.should have_selector('title', :text => "NGS App")
			end
			it "should not have page title" do
				visit '/static_pages/home'
				page.should_not have_selector('h1', :text => ' | Home')
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

	#in home.html.erb
	<h1>NGS App</h1>
	<p>This is the home page.</p>

	# test static_pages_spec.rb
	bundle exec rspec spec/ #good

	git status
	git commit -am "Make an Application Helper"

# Filling in the layout
	git checkout -b filling-in-layout
	# in application.html.erb
	# in home.html.erb
	# integrate bootstrap
		# make costum.css.scss
	# make partials
		# _shim
		# _header
		# _footer
	# in static_pages_spec.rb
	# in routes.erb
	NgsApp::Application.routes.draw do
		root              :to => 'static_pages#home'

		match '/help',    :to => 'static_pages#help'
		match '/about',   :to => 'static_pages#about'
		match '/contact', :to => 'static_pages#contact'

	# make utilities.rb
	# in application_helper.rb

	# add Sign up page
		rails generate controller Users new --no-test-framework
		rails generate integration_test user_pages

		# in routes.erb
		NgsApp::Application.routes.draw do
			root              :to => 'static_pages#home'

			match '/signup',  :to => 'users#new'

			match '/help',    :to => 'static_pages#help'
			match '/about',   :to => 'static_pages#about'
			match '/contact', :to => 'static_pages#contact'

		# in user_pages_spec.rb

		# in new.html.erb

		mkdir spec/helpers/
		ls spec/helpers/
		touch spec/helpers/application_helper_spec.rb

		# in application_helper_spec.rb

	# remove index.html
	rm -f public/index.html

	git status
	git add .
	git commit -m "Finish layout and routes"
	git checkout filling-in-layout
	git rm public/index.html
	git status
	git commit -am "Delete default Rails index"
	git checkout master
	git merge filling-in-layout
	git push
	git push heroku












