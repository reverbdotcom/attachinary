ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

ActiveRecord::MigrationContext.new("../../dummy/db/migrate").migrate
