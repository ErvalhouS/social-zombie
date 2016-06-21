class Serializers::Trade < Serializers::Base
  structure(:default) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.id,
      updated_at: arg.updated_at.try(:iso8601),
      from_items: arg.from_items,
      to_items: arg.to_items,
      accepted: arg.accepted,
      reviewed: arg.reviewed,
    }
  end
end
