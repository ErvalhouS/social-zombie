class Trade < Sequel::Model
  plugin :timestamps, update_on_create: true
  unrestrict_primary_key

  def from
    Item.find(id: MultiJson.decode(from_items)[0].first.last).survivor
  end
  def to_items=(items)
    self.accepted = true
  end

  def accept(items)
    if items.respond_to? :each
      self.to_items = items
    else
      self.to_items = [items]
    end
    self.accepted = true
    self.save
  end

  def review
    validate_trade
    #Enable trade ability o survivors
    to.trade = true
    from.trade = true
    #Remove items
    from.items =- self.from_items
    to.items =- self.to_items
    #Adding exchanged items
    from.items =+ self.to_items
    to.items =+ self.from_items
    #Marking as reviewed
    self.reviewed=true
    self.save
  end

  def validate_trade
    if self.to_items
    end

  end
end
