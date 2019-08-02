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
  @volunteers = Volunteer.all
  erb(:index)
end

post ('/new_project') do
  Project.new({:title => params[:title], :id => nil}).save
  redirect to('/')
end

get ('/project/:id') do
  @project = Project.find(params[:id].to_i)
  @volunteers = @project.volunteers
  erb(:project)
end

get ('/project/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:project_edit)
end

post ('/project/:id/edit/save_title') do
  @project = Project.find(params[:id].to_i)
  @project.update(params[:title])
  @volunteers = @project.volunteers
  erb(:project)
end

post ('/project/:id/edit/delete') do
  Project.find(params[:id].to_i).delete
  redirect to('/')
end

get ('/volunteer/:id') do
  @volunteer = Volunteer.find(params[:id].to_i)
  erb(:volunteer)
end

post ('/new_volunteer') do
  Volunteer.new({:name => params[:name], :id => nil, :project_id => params[:project_id]}).save
  redirect to('/')
end

post ('/volunteer/:id/edit') do
  @volunteer = Volunteer.find(params[:id].to_i)
  @volunteer.update(params[:name])
  erb(:volunteer)
end
