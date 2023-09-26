require 'spec_helper'

RSpec.describe Item do 
  let(:item) { Item.new('Chalkware Piggy Bank') } 
  it 'can initialize' do 
    expect(item).to be_a(Item)
    expect(item.name).to eq("Chalkware Piggy Bank")
  end
end 
