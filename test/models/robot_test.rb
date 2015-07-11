require_relative '../test_helper'

class RobotTest < Minitest::Test 
  def test_assigns_attributes_correctly
    robot = Robot.new({ name: "Jackomo", 
                        city: "San Francisco" })
    assert_equal "Jackomo", robot.name
    assert_equal "San Francisco", robot.city
  end
end
