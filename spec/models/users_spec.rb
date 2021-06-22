require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "presence validations" do
    before { @user = User.new(name: "Example User", email: "user@example.com",
      tel: "0912345678", password: '123456', password_confirmation: '123456') }
    it "name should be present" do
      @user.name = '   '
      expect(@user).not_to be_valid
    end

    it "email should be present" do
      @user.email = '   '
      expect(@user).not_to be_valid
    end

    it "tel should be present" do
      @user.tel = '   '
      expect(@user).not_to be_valid
    end
  end

  context "length validation" do
    before { @user = User.new(name: "Example User", email: "user@example.com",
      tel: "0912345678", password: '123456', password_confirmation: '123456') }
    it "name should not be too long" do
      @user.name = "a" * 31
      expect(@user).not_to be_valid
    end

    it "email should not be too long" do
      @user.email = "#{"a"*250}@a.com"
      expect(@user).not_to be_valid
    end

    it "tel should not be too long" do
      @user.tel = "0"*11
      expect(@user).not_to be_valid
    end
  end

  context "email format" do
    before { @user = User.new(name: "Example User", email: "user@example.com",
      tel: "0912345678", password: '123456', password_confirmation: '123456') }
    it "email validation should reject" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end

    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context "no duplicate emails" do
    before { @user = User.new(name: "Example User", email: "user@example.com",
      tel: "0912345678", password: '123456', password_confirmation: '123456').save }
    it "validate duplicate emails" do
      duplicate = User.new(name: "duplicate", email: "user@example.com", tel: "0912345678").save
      expect(duplicate).to eq(false)
    end
  end

  context "password validation" do
    before { @user = User.new(name: "Example User", email: "user@example.com",
      tel: "0912345678", password: '123456', password_confirmation: '123456') }
    it "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
    end
  end
end
