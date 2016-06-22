class Serializers::Survivor < Serializers::Base
  structure(:default) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.id,
      updated_at: arg.updated_at.try(:iso8601),
      name:       arg.name,
      age:        arg.age,
      gender:     arg.gender,
      lat:        arg.lat,
      lng:        arg.lng,
      infections: arg.infections,
      items:      arg.items
    }
  end
end
