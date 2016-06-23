class Item < Sequel::Model
  plugin :timestamps, update_on_create: true
  many_to_one :survivor

  def item_value=(value)
    case value
      when 1
        self.name='Ammunition'
      when 2
        self.name='Medication'
      when 3
        self.name='Food'
      when 4
        self.name='Water'
      else
        self.name='Invalid'
    end
  end

  def self.status
    @owners = []
    @resources = {}
    Item.all.each { |resource|
      if resource.survivor.zombie?
        @resources[('infected_'+resource.name.downcase).to_sym] =+ 1
      else
        @resources[resource.name.downcase.to_sym] =+ 1
      end
      @resources[('total_'+resource.name.downcase).to_sym] =+ 1
      unless @owners.include?(resource.survivor_id)
        @owners << resource.survivor_id unless resource.survivor.zombie?
      end
    }
    @resources[:avg_water] = @resources[:total_water]/@owners.size
    @resources[:avg_food] = @resources[:total_food]/@owners.size
    @resources[:avg_medication] = @resources[:total_medication]/@owners.size
    @resources[:avg_ammunition] = @resources[:total_ammunition]/@owners.size
    @resources[:points_lost] = (4*(@resources[:infected_water]||0)) + (3*(@resources[:infected_food]||0)) + (2*(@resources[:infected_medication]||0)) + (@resources[:infected_ammunition]||0)
  end
end
