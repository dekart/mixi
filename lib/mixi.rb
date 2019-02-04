module Mixi
end

# Dependencies
require 'mixi/config'
require 'mixi/user'

# Rails integration
require 'mixi/middleware'
require 'mixi/rails/controller'
require 'mixi/engine'

# Validations
require 'mixi/oauth'
require 'mixi/request_validator'
require 'mixi/payment_validator'
