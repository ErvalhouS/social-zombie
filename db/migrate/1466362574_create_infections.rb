Sequel.migration do
  change do
    create_table(:infections) do
      uuid         :id, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at, default: Sequel.function(:now), null: false

      uuid         :survivor_id
      uuid         :reporter_id
    end
  end
end
