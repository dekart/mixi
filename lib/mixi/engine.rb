module Mixi
  class Engine < ::Rails::Engine
    initializer "mixi.middleware" do |app|
      app.middleware.insert_before(Rack::Head, Mixi::Middleware)
    end

    initializer "mixi.controller_extension" do
      ActiveSupport.on_load :action_controller do
        ActionController::Base.send(:include, Mixi::Rails::Controller)
      end
    end
  end
end
