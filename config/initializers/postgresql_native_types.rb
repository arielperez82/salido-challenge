require "active_record/connection_adapters/postgresql_adapter"

module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      NATIVE_DATABASE_TYPES.merge!(
        datetime:  { name: "timestamptz" },
        timestamp: { name: "timestamptz" },
        string:    { name: "text" }
      )
    end
  end
end