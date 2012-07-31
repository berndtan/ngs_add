require 'spec_helper'

describe ApplicationHelper do
	before (:all) do
	    ActiveRecord::Base.establish_connection(
	      	:adapter => "mysql2",
				:host => "localhost",
				:database => "ngs_app_development",
				:username => "berndtan",
				:password => "an2709be" )
	end

	describe "full_title" do
		it "should include the page title" do
			full_title('foo').should =~ /foo/
		end

		it "should include the base title" do
			full_title('foo').should =~ /NGS App/
		end

		it "should not include a bar on the home page" do
			full_title('').should_not =~ /\|/
		end

	end
end