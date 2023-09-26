require 'spec_helper'
RSpec.describe Auction do 
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') } 
  let(:auction) { Auction.new } 
  
  it 'can initialize' do 
    expect(auction).to be_a(Auction)
    expect(auction.items).to eq([])
  end
  
  describe '#Add item' do 
    it 'will add an Item to the Auction' do 
      auction.add_item(item1)
      expect(auction.items).to eq([item1])
      auction.add_item(item2)
      expect(auction.items).to eq([item1, item2])
    end
  end

  describe '#item_names' do 
    it 'will return the name of each Item in the Auction' do 
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end
 