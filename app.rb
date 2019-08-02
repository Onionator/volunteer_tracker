require('sinatra')
require('sinatra/reloader')
require('pry')
require("pg")
require('./lib/project')
require('./lib/volunteer')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get ('/') do
  @projects = Project.all
  erb(:index)
end

post ('/new_project') do
  Project.new({:title => params[:title], :id => nil}).save
  redirect to('/')
end

get ('/project/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end
