require 'rails_helper'

describe 'User' do

  subject(:user) { User.create(
                            first_name: "Fifi",
                            image_url: "me.png",
                            email: "example.com",
                            pwd: "secret"
                            )}

    [:first_name, :image_url, :email, :pwd].each do |prop|
        it {is_expected.to respond_to prop}
    end


    #This tests for uniqueness in the User model
    it { is_expected.to validate_uniqueness_of :email}

end