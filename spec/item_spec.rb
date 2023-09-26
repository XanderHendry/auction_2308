require 'spec_helper'

RSpec.describe Item do 
  let(:item) { Item.new('Chalkware Piggy Bank') } 
  it 'can initialize' do 
    expect(item).to be_a(Item)
    expect(item.name).to eq("Chalkware Piggy Bank")
    expect(item.bids).to eq({})
  end
  context 'adding and tracking bids' do
    let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
    let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
    describe '#add_bid' do 
      it 'will add a bid to the Items bid hash, with an Attendee as the key, and the bid as the value' do
        item.add_bid(attendee2, 20)
        item.add_bid(attendee1, 22)
        expect(item.bids).to eq({
          attendee2 => 20,
          attendee1 => 22
        })
      end
    end
    describe '#current_high_bid' do 
      it 'will return the current highest bid as an integer' do 
        item.add_bid(attendee2, 20)
        item.add_bid(attendee1, 22)
        expect(item.current_high_bid).to eq(22)
      end
    end
  end
end 
