require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid when all fields are correctly given" do
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = 'SandM@bdsm.ca'
      @password = 'saturdaynight'
      @password_confirmation = 'saturdaynight'

      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to be_valid
    end

    it "is not valid without a first_name" do
      @first_name = nil
      @last_name = 'Mathews'
      @email = 'SandM@bdsm.ca'
      @password = 'saturdaynight'
      @password_confirmation = 'saturdaynight'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end

    it "is not valid without a last_name" do
      @first_name = 'Stacy'
      @last_name = nil
      @email = 'SandM@bdsm.ca'
      @password = 'saturdaynight'
      @password_confirmation = 'saturdaynight'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end

    it "is not valid without a email" do
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = nil
      @password = 'saturdaynight'
      @password_confirmation = 'saturdaynight'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end

    it "is not valid without a password" do
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = 'SandM@bdsm.ca'
      @password = nil
      @password_confirmation = 'saturdaynight'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end

    it "is not valid if the passwords and password confirmation are different" do
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = 'SandM@bdsm.ca'
      @password = 'saturdaynight'
      @password_confirmation = nil
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end

    it "is not valid without a password of 8 characters" do
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = 'SandM@bdsm.ca'
      @password = 'night'
      @password_confirmation = 'night'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end

    it "is not valid without a password confirmation" do
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = 'SandM@bdsm.ca'
      @password = 'saturdaynight'
      @password_confirmation = 'saturdaynight'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      @user.valid?
      expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    it "is not valid if the email is already in use, ignoring mixed case" do
      @user_first = User.create(
        :first_name => 'Sandy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
      @user_first.save
      
      @first_name = 'Stacy'
      @last_name = 'Mathews'
      @email = 'SANDM@BDSM.CA'
      @password = 'saturdaynight'
      @password_confirmation = 'saturdaynight'
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "successfully logs in when provided proper information" do
      @user1 = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
    end
    it "successfully logs in when given mixed case email" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
    end
    it "successfully logs in when user adds space on either side of email" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
    end
    it "successfully  prevents logging in when provided wrong information" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
    end
  end
end
