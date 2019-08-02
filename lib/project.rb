require 'pry'

class Project
  attr_accessor :name
  attr_reader :id
  def initialize(attritbutes)
    @name = attritbutes.fetch(:name)
    @id = attritbutes.fetch(:id)
  end
  def self.all
    projects = []
    returned_projects = DB.exec("SELECT * FROM projects;")
    returned_projects.each do |project|
      name = project.fetch("name")
      id = project.fetch("id")
      projects.push(Project.new({:name => name, :id => id, :project_id => project_id}))
    end
    projects
  end
  def update(name)
    @name = name ? name : @name
    DB.exec("UPDATE projects SET name = '#{name}' WHERE porject_id = #{@project_id}")
  end
  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end
end
