require_relative '../test_helper'

class RobotManagerTest < Minitest::Test 
  def test_it_creates_a_robot
    create_robot
    robot = RobotManager.find(RobotManager.all.first.id)
    assert_equal "Jackomo", robot.name
    assert_equal "San Francisco", robot.city
    assert_equal "California", robot.state
    assert_equal "avatar_url", robot.avatar
    assert_equal "June 20, 2015", robot.birthdate
    assert_equal "July 12, 2015", robot.date_hired
    assert_equal "Accounting", robot.department
  end

  def test_it_returns_all_robots
    2.times { create_robot }
    robots = RobotManager.all
    assert_equal 2, robots.count
  end

  def test_it_finds_a_robot
    create_robot
    robot = RobotManager.find(RobotManager.all.first.id)
    assert_equal "Jackomo", robot.name
  end

  def test_it_updates_a_robot
    create_robot
    robot = RobotManager.find(RobotManager.all.first.id)
    RobotManager.update(robot.id,
                        { name: "Jackomo Fi Na Nei",
                          city:       "San Francisco",
                          state:      "California",
                          avatar:     "avatar_url",
                          birthdate:  "June 20, 2015",
                          date_hired: "July 12, 2015",
                          department: "Accounting" })
    robot = RobotManager.find(RobotManager.all.first.id)
    assert_equal "Jackomo Fi Na Nei", robot.name
  end

  def test_it_destroys_a_robot
    create_robot
    RobotManager.delete(RobotManager.all.first.id)
    assert_equal 0, RobotManager.all.count
  end

  private

  def create_robot
    RobotManager.create({ name:       "Jackomo", 
                          city:       "San Francisco",
                          state:      "California",
                          avatar:     "avatar_url",
                          birthdate:  "June 20, 2015",
                          date_hired: "July 12, 2015",
                          department: "Accounting" })
  end
end
