require 'yaml/store'
require 'sequel'

class RobotManager
  def self.database
    if ENV["ROBOT_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/robot_manager_test.sqlite3")
      # @database ||= YAML::Store.new("db/robot_manager_test")
    else
      @database ||= Sequel.sqlite("db/robot_manager_development.sqlite3")
      # @database ||= YAML::Store.new("db/robot_manager")
    end
  end

  def self.create(robot)
    dataset.insert( name: robot[:name],
                    city: robot[:city],
                    state: robot[:state],
                    avatar: robot[:avatar],
                    birthdate: robot[:birthdate],
                    date_hired: robot[:date_hired],
                    department: robot[:department] )
    # database.transaction do
    #   database['robots'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['robots'] << { "id" => database['total'], "name" => robot[:name], "city" => robot[:city], "state" => robot[:state], "avatar" => robot[:avatar], "birthdate" => robot[:birthdate], "date_hired" => robot[:date_hired], "department" => robot[:department] } 
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end 
  end

  def self.all
    dataset.to_a.map { |data| Robot.new(data) }
    # raw_robots.map { |data| Robot.new(data) }
  end

  def self.raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    Robot.new(dataset.where(id: id).first)
  end

  def self.update(id, robot)
    dataset.where(id: id).update(robot)
    # database.transaction do
    #   target = database['robots'].find { |row| row["id"] == id }
    #   target["name"] = robot[:name]
    #   target["avatar"] = robot[:avatar]
    #   target["city"] = robot[:city]
    #   target["state"] = robot[:state]
    #   target["birthdate"] = robot[:birthdate]
    #   target["date_hired"] = robot[:date_hired]
    #   target["department"] = robot[:department]
    # end
  end

  def self.delete(id)
    dataset.where(id: id).delete
    # database.transaction do
    #   database["robots"].delete_if { |robot| robot["id"] == id }
    # end
  end

  def self.average_age
    if all.empty?
      "No Robots"
    else
      all.map { |robot| robot.age }.reduce(0, :+) / all.count 
    end
  end
  
  def self.hired_per_year
    robots_hired_per_year.map do |year, robots|
      [year, robots.count]
    end.to_h
  end

  def self.number_of_robots_per(parameter)
    robots_grouped_by(parameter).map do |parameter, robots|
      [parameter, robots.count]
    end.to_h
  end
  
  private

  def self.robots_hired_per_year
    all.group_by do |robot|
      Date.parse(robot.date_hired).year
    end
  end 

  def self.robots_grouped_by(parameter)
    all.group_by do |robot|
     robot.send(parameter)
    end
  end

  def self.delete_all
    dataset.delete 
    # database.transaction do
    #   database['robots'] = []
    #   database['total'] = 0
    # end
  end

  def self.dataset
    database.from(:robots)
  end
end

# A robot has a name, city, state, avatar, birthdate, date hired, and department.
