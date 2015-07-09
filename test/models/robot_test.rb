require_relative '../test_helper'

class RobotTest < Minitest::Test 
  def test_assigns_attributes_correctly
    robot = Robot.new({ "name"       => "Jackomo", 
                      "city" => "San Francisco",
                      "id"          => 1 })
    assert_equal "Jackomo", robot.name
    assert_equal "San Francisco", robot.city
    assert_equal 1, robot.id
  end
end
