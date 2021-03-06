require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid when all input is valid" do
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
      @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password,
      password_confirmation: @password_confirmation
      )
      @user.valid?
      #show different more detailed syntax
      expect(@user.errors.messages[:password_confirmation]).to include("can't be blank")
    end

    it "is not valid if the email is already in use, ignoring mixed case" do
      @user = User.new(
        first_name: 'Stacy',
        last_name: 'Mathews',
        email: 'SandM@bdsm.ca',
        password: 'saturdaynight',
        password_confirmation: 'saturdaynight'
      )
      @user.save

      @user_dup = User.new(
        first_name: 'Stacy',
        last_name: 'Mathews',
        email: 'SandM@bdSM.ca',
        password: 'saturdaynight',
        password_confirmation: 'saturdaynight'
      )
      @user_dup.valid?
      expect(@user_dup).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "successfully logs in when provided proper information" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
      @email = 'SandM@bdsm.ca'
      @password = 'saturdaynight'
      @authenticated = User.authenticate_with_credentials(@email, @password)

      expect(@authenticated.email).to eq(@email)
      expect(@authenticated.password_digest).to_not eq(@password)
    end
    it "successfully logs in when given different mixed case email" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
      @email = 'SANDM@BDSM.CA'
      @password = 'saturdaynight'
      @authenticated = User.authenticate_with_credentials(@email, @password)

      expect(@authenticated.email).to eq(@email)
    end
    it "successfully logs in when user adds space on either side of email" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
      @email = '      SANDM@BDSM.CA      '
      @password = 'saturdaynight'
      @authenticated = User.authenticate_with_credentials(@email, @password)

      expect(@authenticated.email).to eq(@email)
    end
    it "successfully  prevents logging in when provided wrong information" do
      @user = User.create(
        :first_name => 'Stacy',
        :last_name => 'Mathews',
        :email => 'SandM@bdsm.ca',
        :password => 'saturdaynight',
        :password_confirmation => 'saturdaynight'
      )
      @email = 'SANDM@BDSM.CA'
      @password = 'sittingathomealonenight'
      @authenticated = User.authenticate_with_credentials(@email, @password)

      expect(@authenticated).to eq(false)
    end
  end
end
