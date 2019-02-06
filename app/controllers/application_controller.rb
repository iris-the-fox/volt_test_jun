class ApplicationController < ActionController::API
  
  protected
    def self.set_pagination_headers(name, options = {})
      after_action(options) do |controller|
        results = instance_variable_get("@#{name}")
        headers["X-Total-Pages"] = results.total_pages
        headers["X-Total"] =  results.total_entries
      end
    end


end
