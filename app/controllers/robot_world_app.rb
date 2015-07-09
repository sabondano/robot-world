class RobotWorldApp < Sinatra::Base
  get '/' do
    @average_age = RobotManager.average_age    
    @robots_hired_per_year = RobotManager.hired_per_year
    @robots_per_department = RobotManager.number_of_robots_per("department")
    @robots_per_city = RobotManager.number_of_robots_per("city")
    @robots_per_state = RobotManager.number_of_robots_per("state")
    erb :dashboard
  end

  get '/robots' do
    @robots = RobotManager.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    RobotManager.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = RobotManager.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = RobotManager.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    RobotManager.update(id.to_i, params[:robot])
    redirect "robots/#{id}"
  end

  delete '/robots/:id' do |id|
    RobotManager.delete(id.to_i)
    redirect '/robots'
  end

  not_found do
    erb :error
  end
end
