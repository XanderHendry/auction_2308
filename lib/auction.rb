class Auction
  attr_reader :items
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end

  def unpopular_items
    @items.find_all { |item| item.bids == {} }
  end

  def potential_revenue
    bids = @items.find_all { |item| item.bids != {} }
    bids.map { |item| item.current_high_bid }.sum
  end

  def bidders
    placed_bids = @items.find_all { |item| item.bids != {} }
    bidders = placed_bids.flat_map { |item| item.bids.keys }
    # require 'pry'; binding.pry
    bidders.flat_map do |attendee| 
      attendee.name 
    end
  end
end
