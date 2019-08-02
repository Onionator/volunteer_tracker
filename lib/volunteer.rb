require 'pry'

class Volunteer
  attr_accessor :name
  attr_reader :id
  def initialize(attritbutes)
    @name = attritbutes.fetch(:name)
    @id = attritbutes.fetch(:id)
  end
end
