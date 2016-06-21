class Infection < Sequel::Model
  plugin :timestamps, update_on_create: true

  one_to_one :@negan
  one_to_one :reporter


end
