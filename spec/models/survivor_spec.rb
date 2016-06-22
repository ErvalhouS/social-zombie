<<<<<<< HEAD
require 'rails_helper'

RSpec.describe Survivor, type: :model do
  fixtures :survivors

  it "to be valid" do
      expect(survivors(:negan)).to be_valid
  end

  it "to be invalid without a name, age or gender" do
    expect {
      create_survivor(name: nil)
    }.not_to change(Survivor, :count)

    expect {
      create_survivor(age: nil)
    }.not_to change(Survivor, :count)

    expect {
      create_survivor(gender: nil)
    }.not_to change(Survivor, :count)
  end

  it "to add inventory items only on creation" do

    expect {
      create_survivor(initial_items: [1,1,1])
    }.to change(Item, :count)

    expect {
      survivor = create_survivor
      survivor.initial_items = [1,2,3]
      survivor.save
    }.to_not change(Item, :count)

    survivor = create_survivor
    expect {
      survivor.items << Item.new(item_value: 4, survivor_id: survivor)
      survivor.save
    }.to_not change(survivor.items, :count)

  end

  it "to have many items" do
    expect { survivors(:negan).items }.not_to raise_error
  end

  it "to be able to flag another survivor as infected" do
    survivor = create_survivor
    expect {
      survivors(:negan).flag_as_infected(survivor)
    }.to change(survivor.infections, :count)
  end

  it "be a zombie afeter 3 infected reports" do
    survivor = create_survivor
    survivors(:negan).flag_as_infected(survivor)
    survivors(:negan).flag_as_infected(survivor)
    survivors(:negan).flag_as_infected(survivor)
    expect(survivor).to be_a_zombie
  end

  it "to be able to trade evenly with others" do
    survivor1 = create_survivor(initial_items: [1,1,1,1])
    survivor2 = create_survivor(initial_items: [2,2])

    Item.exchange(survivor1.get_items(1,1), survivor2.get_items(2))

    expect(survivor1.get_items(2)).not_to be_nil
    expect(survivor2.get_items(1,1)).not_to be_nil
  end

  it "to be unable to trade unevenly with others" do
    expect {
      survivor1 = create_survivor(initial_items: [1,1,1,1])
      survivor2 = create_survivor(initial_items: [2,2])
      Item.exchange(survivor1.get_items(1), survivor2.get_items(2))
    }.to raise_error('Items can not be traded unevenly!')
  end

=======
require "spec_helper"

RSpec.describe Survivor do
>>>>>>> 0-0-1
end
