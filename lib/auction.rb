require 'Date'

class Auction
  attr_reader :items,
              :date
  def initialize
    @items = []
    @date = Date.today.strftime('%d/%m/%Y')
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

  def close_auction
    auction_results = {}
    unsold = unpopular_items
    unsold.each do |item| 
      auction_results[item] = 'Not sold'
      item.close_bidding
      item.sell
    end
    @items.each do |item|
      item.close_bidding
      item.bids.each do |attendee, bid|
        if item.current_high_bid == bid && attendee.budget > bid
          attendee.buy_item(bid)
          item.sell
          auction_results[item] = attendee
          # require 'pry'; binding.pry
        elsif attendee.budget > bid && item.sold == false
          attendee.buy_item(bid)
          auction_results[item] = attendee
          item.sell
          # require 'pry'; binding.pry
        end
      end
    end
    # require 'pry'; binding.pry
    auction_results
  end
end
