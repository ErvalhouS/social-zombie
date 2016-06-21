class Item < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_one :survivor

  def self.status
    @owners = []
    Resource.all.eager(:owner).each { |resource|
      if resource.owner.zombie?
        @resources[('infected_'+resource.name.downcase).to_sym] =+ 1
      else
        @resources[resource.name.downcase.to_sym] =+ 1
      end
      @resources[('total_'+resource.name.downcase).to_sym] =+ 1
      unless @owners.include?(resource.owner.id)
        @owners << resource.owner.id
      end
    }
    @resources[:avg_water] = @resources[:total_water]/@owners.size
    @resources[:avg_food] = @resources[:total_food]/@owners.size
    @resources[:avg_medication] = @resources[:total_medication]/@owners.size
    @resources[:avg_ammunition] = @resources[:total_ammunition]/@owners.size
    @resources[:points_lost] = (4*@resources[:infected_water]) + (3*@resources[:infected_food]) + (2*@resources[:infected_medication]) + @resources[:infected_ammunition]
  end
end
