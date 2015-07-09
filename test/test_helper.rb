ENV['ROBOT_MANAGER_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'tilt/erb'

class Minitest::Test
  def teardown
    RobotManager.delete_all
  end
end

Capybara.app = RobotWorldApp
Capybara.save_and_open_page_path = "/tmp"

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
