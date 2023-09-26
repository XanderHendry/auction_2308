require 'spec_helper'
RSpec.describe Attendee do 
  let(:attendee) { Attendee.new({name: 'Megan', budget: '$50'}) } 
  it 'can initialize' do 
    expect(attendee).to be_a(Attendee)
    expect(attendee.name).to eq("Megan")
  end

  describe '#budget' do 
    it 'will return the Attendees budget as an integer' do 
      expect(attendee.budget).to eq(50)
    end
  end
end 
