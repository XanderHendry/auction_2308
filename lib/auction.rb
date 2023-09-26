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

  def bidder_finder
    placed_bids = @items.find_all { |item| item.bids != {} }
    bidders = placed_bids.flat_map { |item| item.bids.keys }
  end

  def bidders
    bidders = bidder_finder
    bidders.flat_map do |attendee| 
      attendee.name 
    end
  end

  def bidder_info
    bidder_info = {}
    bidders = bidder_finder
    bidders.each do |attendee|
      bidder_items = 
      bidder_info[attendee] = {
        :budget => attendee.budget,
        :items => @items.find_all { |item| item.bids[attendee] }
      }
    end
    bidder_info
  end
end
