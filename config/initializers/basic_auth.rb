Rails.application.config.middleware.insert_after(::Rack::Runtime, "::Rack::Auth::Basic") do |username, password|
  username == ENV["BASIC_AUTH_USERNAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
end
