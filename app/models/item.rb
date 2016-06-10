class Item < ActiveRecord::Base
  belongs_to :survivor

  #boolean to unlock items trade
  attr_accessor :trade
  validate :forbid_item_creation

  def self.inventory(who)
    Item.all.where(survivor: who)
  end

  def self.exchange(items1, items2)
    if Item.find(items1.first).survivor.zombie? || Item.find(items2.first).survivor.zombie?
      raise 'Zombies only trade on brains!'
    end
    if items1.nil? || items2.nil?
      raise 'Invalid items!'
    end
    if items1.map{|a| Item.find(a).item_value}.inject(:+) == items2.map{|a| Item.find(a).item_value}.inject(:+)

      survivor1 = Item.find(items1.first).survivor_id
      survivor2 = Item.find(items2.first).survivor_id
      items1.map{|a| Item.find(a).survivor_id = survivor2}
      items2.map{|a| Item.find(a).survivor_id = survivor1}

    else
      raise 'Items can not be traded unevenly!'
    end
  end

  def self.resource_per_capita
    returned = Array.new
    [1,2,3,4].each do |resource_value|
      resources = Array.new
      Item.all.each { |item|
        resources << item if item.item_value==resource_value
      }
      returned << (resources.count / Survivor.all.count).round
    end
    returned
  end

  def self.lost_resources
    resources = Array.new
    hash = {}
    Item.all.each { |item|
      resources << item if !item.survivor.nil? && item.survivor.zombie?
      hash[item.item_value] =+ 1
    }
    return [resources.map{|item| item.item_value}.inject(:+), hash]
  end
  private

    def forbid_item_creation
      errors[:item_value] = 'can not be added, only traded!' unless self.trade
    end
end
