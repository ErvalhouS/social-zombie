Sequel.migration do
  change do
    create_table(:items) do
      uuid         :id, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at, default: Sequel.function(:now), null: false
      Integer      :item_value, null: false, readonly: true
      String       :name
      uuid         :survivor_id
    end
  end
end
