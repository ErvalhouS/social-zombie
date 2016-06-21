class Trade < Sequel::Model
  plugin :timestamps, update_on_create: true
  unrestrict_primary_key

  def to
    Item.find(MultiJson.decode(to_items).to_hash[:items].first).survivor
  end

  def from
    Item.find(MultiJson.decode(from_items).to_hash[:items].first).survivor
  end
end
