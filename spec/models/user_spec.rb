require 'rails_helper'

describe User do

  before { @user = FactoryGirl.create(:user) }

  it "has a valid factory" do
    expect(@user).to be_valid
  end

  it "follows name convention" do
    @user.name = "2*+"
    expect(@user).not_to be_valid
  end

  it "is invalid without email" do
    @user.email = nil
    expect(@user).not_to be_valid
  end

  describe "when email format is invalid" do

    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do

    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "filter users by search term" do

    before {
      @bob = FactoryGirl.create(:user, name: "Robert", email: "paulson@example.com")
      @edd = FactoryGirl.create(:user, name: "Edward Cullen", email: "robert_pattison@example.com")
      @ken = FactoryGirl.create(:user, name: "Ken", email: "ken@example.com")
    }

    context "matching" do

      it "returns an array of results that match" do
        expect(User.search("robert")).to eq [@bob, @edd]
      end
    end

    context "non-matching" do

      it "does not returns users that don't match" do
        expect(User.search("robert")).not_to include @ken
      end
    end
  end

end
