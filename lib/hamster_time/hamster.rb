require 'active_record'

module Hamster
  def self.establish_connection
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: File.expand_path(ENV['HAMSTER_DB_PATH'])
    )
  end

  class Fact < ActiveRecord::Base
    belongs_to :activity
    has_and_belongs_to_many :tags, join_table: 'fact_tags'
    default_scope -> { order('facts.id ASC') }

    def tag_names
      tags.pluck(:name).join(',')
    end
  end

  class Activity < ActiveRecord::Base
    has_many :facts
    belongs_to :category
  end

  class Category < ActiveRecord::Base
    has_many :activities
  end

  class Tag < ActiveRecord::Base
    has_and_belongs_to_many :facts, join_table: 'fact_tags'
  end
end
