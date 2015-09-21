ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

FactoryGirl.reload
FactoryGirlSequences.reload

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
