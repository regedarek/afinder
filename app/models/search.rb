class Search < ActiveRecord::Base
  def self.recent(limit=5)
    Search.limit(limit).reverse_order
  end
end
