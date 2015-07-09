require_relative '../test_helper'

class RobotManagerTest < Minitest::Test 
  def test_it_creates_a_robot
    RobotManager.create({ :name       => "Jackomo", 
                         :city => "San Francisco"})
    robot = RobotManager.find(1)
    assert_equal "Jackomo", robot.name
    assert_equal "San Francisco", robot.city
    assert_equal 1, robot.id
  end
end
