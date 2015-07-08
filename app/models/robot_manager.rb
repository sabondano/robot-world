require 'yaml/store'
require_relative 'robot'

class RobotManager
  def self.database
    @database ||= YAML::Store.new("db/robot_manager")
  end

  def self.create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'], "name" => robot[:name], "city" => robot[:city], "state" => robot[:state], "avatar" => robot[:avatar], "birthdate" => robot[:birthdate], "date_hired" => robot[:date_hired], "department" => robot[:department] } 
    end
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end 
  end

  def self.all
    raw_robots.map { |data| Robot.new(data) }
  end

  def self.raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.update(id, robot)
    database.transaction do
      target = database['robots'].find { |row| row["id"] == id }
      target["name"] = robot[:name]
      target["avatar"] = robot[:avatar]
      target["city"] = robot[:city]
      target["state"] = robot[:state]
      target["birthdate"] = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      database["robots"].delete_if { |robot| robot["id"] == id }
    end
  end

  def self.average_age
    all
  end
end

# A robot has a name, city, state, avatar, birthdate, date hired, and department.
