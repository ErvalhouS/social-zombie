class Infection < ActiveRecord::Base
  has_one :reporter
  has_one :survivor
end
