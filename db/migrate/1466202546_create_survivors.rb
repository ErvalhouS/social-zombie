Sequel.migration do
  change do
    create_table(:survivors) do
      uuid         :id, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at, default: Sequel.function(:now), null: false
      String       :name,       unique: true, null: false
      String       :encrypted_password      , null: false
      Integer      :age
      String       :gender
      Float        :lat
      Float        :lng
      String       :ip_address
      String       :token
    end
  end
end
