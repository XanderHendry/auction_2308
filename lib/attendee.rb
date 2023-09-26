class Attendee
attr_reader :name
  def initialize(attendee_info)
    @name = attendee_info[:name]
    @budget = attendee_info[:budget]
  end

  def budget
    @budget.tr("$", "").to_i
  end

  def buy_item(amount)
    budget = @budget.tr("$", "").to_i
    budget = (budget -= amount).to_s
    @budget = "$" + budget
  end
end
