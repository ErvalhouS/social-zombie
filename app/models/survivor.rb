class Survivor < ActiveRecord::Base

  geocoded_by :ip_address,
              :latitude => :lat, :longitude => :lng
  after_validation :geocode

  has_many :items, dependent: :destroy
  has_many :infections

  validates_presence_of :name, :age, :gender

  #to be able to pass a array of initial items on create
  attr_accessor :initial_items
  validate :add_items, on: :create


  def flag_as_infected(survivor)
    survivor.infections << Infection.create(reporter_id: self.id)
  end

  def get_items(*args)
    grabbed_items = Array.new
    if args.respond_to?(:each)
      args.each do |item_value|
        self.items.each do |item|
          grabbed_items << item.id if item.item_value == item_value
          break
        end
      end
    else
      self.items.each do |item|
        grabbed_items << item.id if item.item_value == args
        break
      end
    end
    grabbed_items
  end

  def has_items?
    self.items.any? ? true : false
  end

  def zombie?
    self.infections.count >= 3
  end

  def self.infected_percentage
    infected = Array.new
    Survivor.all.each { |survivor|
      infected << survivor if survivor.zombie?
    }
    ((infected.count / Survivor.all.count)*100)
  end

  def self.healthy_percentage
    healthy = Array.new
    Survivor.all.each { |survivor|
      healthy << survivor unless survivor.zombie?
    }
    ((healthy.count / Survivor.all.count)*100)
  end

  private

    def add_items
      if self.initial_items.respond_to?(:each)
        #unlock item trade ability to add initial items through trade boolean
        self.initial_items.each do |item|
          self.items << Item.create(item_value: item, survivor_id: self.id, trade: true)
        end

      end
    end
end
