require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "ac6f4aa3006976bd0b3771a31ccf8d0118480daf09c0d78c243e8cb847a30d29"

  url_format "/media/:job/:name"

  datastore(Rails.configuration.x.dragonfly.datastore, Rails.configuration.x.dragonfly.options)
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
