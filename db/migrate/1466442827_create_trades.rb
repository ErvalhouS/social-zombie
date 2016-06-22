Sequel.migration do
  change do
    create_table(:trades) do
      uuid         :id, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at, default: Sequel.function(:now), null: false
      column       :from_items, :json,                 default: []
      column       :to_items, :json,                   default: []
      Boolean      :accepted, read_only: true
      Boolean      :reviewed, read_only: true
    end
  end
end
