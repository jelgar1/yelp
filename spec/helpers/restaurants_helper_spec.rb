require 'rails_helper'

def sign_in
 User.create(email: "test@live.com", password: "password", password_confirmation: "password")
 visit '/restaurants'
 click_link 'Sign in'
 fill_in "Email", with: "test@live.com"
 fill_in "Password", with: "password"
 click_button 'Log in'
end

def sign_in2
  User.create(email: "test2@live.com", password: "password2", password_confirmation: "password2")
  visit '/restaurants'
  click_link 'Sign in'
  fill_in "Email", with: "test2@live.com"
  fill_in "Password", with: "password2"
  click_button 'Log in'
end

def create_restaurant
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'Hawksmoor'
  click_button 'Create Restaurant'
end

# Specs in this file have access to a helper object that includes
# the RestaurantsHelper. For example:
#
# describe RestaurantsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
# RSpec.describe RestaurantsHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
