require 'spec_helper'
RSpec.describe Auction do 
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') } 
  let(:item3) { Item.new('Homemade Chocolate Chip Cookies') } 
  let(:item4) { Item.new('2 Days Dogsitting') } 
  let(:item5) { Item.new('Forever Stamps') }
  let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
  let(:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }
  let(:auction) { Auction.new } 
  
  it 'can initialize' do 
    expect(auction).to be_a(Auction)
    expect(auction.items).to eq([])
  end
  
  describe '#add item' do 
    it 'will add an Item to the Auction' do 
      auction.add_item(item1)
      expect(auction.items).to eq([item1])
      auction.add_item(item2)
      expect(auction.items).to eq([item1, item2])
    end
  end

  describe '#item names' do 
    it 'will return the name of each Item in the Auction' do 
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
  context 'Checking bids on Items in the Auction' do
    before(:each) do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
     end
    describe '#unpopular items' do 
      it 'will return items that have no bids' do 
        expect(auction.unpopular_items).to eq([item2, item3, item5])
        item3.add_bid(attendee2, 15)
        expect(auction.unpopular_items).to eq([item2, item5])
      end
    end
    describe '#potential revenue' do 
      it 'will return the sum of all items highest bids' do 
        expect(auction.potential_revenue).to eq(72)
      end
    end
  end
  context 'Checking Attendees that have placed bids' do
    before(:each) do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
    end
    describe '#bidders' do 
      it 'will return an array of bidders names as Strings' do 
        expect(auction.bidders).to eq(["Megan", "Bob"])
        item4.add_bid(attendee3, 50)
        expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
      end
    end

    describe '#bidder info' do 
      it 'will return a hash with Attendees as keys pointing to a sub hash with their budget and items they have bid on' do
        item4.add_bid(attendee2, 45)
        item4.add_bid(attendee3, 50)
        expect(auction.bidder_info).to eq({
          attendee1 => {
            :budget => 50,
            :items => [item1]
          },
          attendee2 => {
            :budget => 75,
            :items => [item1, item4]
          },
          attendee3 => {
            :budget => 100,
            :items => [item4]
          }
        })
      end
    end
  end
end
