require 'pry'

class Project
  attr_accessor :title
  attr_reader :id
  def initialize(attritbutes)
    @title = attritbutes.fetch(:title)
    @id = attritbutes.fetch(:id)
  end
  def save
    project = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = project.first.fetch("id").to_i
  end
  def self.all
    projects = []
    returned_projects = DB.exec("SELECT * FROM projects;")
    returned_projects.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end
  def update(title)
    @title = title
    DB.exec("UPDATE projects SET title = '#{title}' WHERE id = #{@id};")
  end
  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end
  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    Project.new({:title => project.first.fetch("title"), :id => id})
  end
  def ==(compare)
    self.title == compare.title
  end
  def volunteers
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
    list_of_volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      list_of_volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => @id}))
    end
    list_of_volunteers
  end
end
