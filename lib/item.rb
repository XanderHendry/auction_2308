class Item
  attr_reader :name,
              :bids,
              :sold
  def initialize(name)
    @bids = {}
    @name = name
    @open = true
    @sold = false
  end

  def add_bid(attendee, bid)
    if @open == true
      @bids[attendee] = bid
    else
      "Bidding on this item is closed."
    end
  end

  def current_high_bid
    @bids.values.max
  end

  def close_bidding
    if @open == true
      @open = false
      "Bidding in now closed for the #{@name}." 
    end
  end

  def sell
    @sold = true
  end
end
