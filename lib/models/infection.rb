class Infection < Sequel::Model
  plugin :timestamps, update_on_create: true
  unrestrict_primary_key


end
