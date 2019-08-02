require 'pry'

class Volunteer
  attr_accessor :name, :project_id
  attr_reader :id
  def initialize(attritbutes)
    @name = attritbutes.fetch(:name)
    @id = attritbutes.fetch(:id)
    @project_id = attritbutes.fetch(:project_id)
  end
  def save
    volunteer = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = volunteer.first.fetch("id").to_i
  end
  def self.all
    volunteers = []
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id")
      project_id = volunteer.fetch("project_id")
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end
  def update(name, project_id)
    @name = name
    @project_id = project_id
    DB.exec("UPDATE volunteers SET name = '#{name}' WHERE id = #{@id};")
    DB.exec("UPDATE volunteers SET project_id = '#{project_id}' WHERE porject_id = #{@project_id};")
  end
  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end
  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")
    Volunteer.new({:name => volunteer.first.fetch("name"), :id => id, :project_id => volunteer.first.fetch("project_id")})
  end
  def ==(compare)
    self.name == compare.name
  end
end
