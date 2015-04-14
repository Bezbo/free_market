require 'rails_helper'

describe Item do

  before { @item = FactoryGirl.create(:item) }

  it "has valid factory" do
    expect(@item).to be_valid
  end

  it "is invalid without a name" do
    @item.name = nil
    expect(@item).not_to be_valid
  end

  it "is invalid without an address" do
    @item.address = nil
    expect(@item).not_to be_valid
  end

  describe "filter items by search term" do

    before {
      @cattle = FactoryGirl.create(:item, name: "cattle")
      @cat    = FactoryGirl.create(:item, name: "cat")
      @poodle = FactoryGirl.create(:item, name: "poodle")
    }

    context "matching" do
      it "returns an array of results that match" do
        expect(Item.search("cat")).to eq [@cattle, @cat]
      end
    end

    context "non-matching" do
      it "does not returns items that don't match" do
        expect(Item.search("cat")).not_to include @poodle
      end
    end
  end

end

