task :default do
  sh "RAILS=2.3.12 && (bundle || bundle install) && bundle exec rake test"
  sh "RAILS=3.0.10 && (bundle || bundle install) && exec rake test"
  sh "RAILS=3.1.2 && (bundle || bundle install) && exec rake test"
  sh "git checkout Gemfile.lock"
end

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name = 'mixi'
    gem.summary = "Mixi integration for Rack & Rails application"
    gem.email = "axl1232@gmail.com"
    gem.homepage = "http://github.com/axl1232/mixi"
    gem.authors = ["Svetlana Tarasova", "axl"]
    gem.version = '0.1.2'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler"
end
