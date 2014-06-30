# cribbed from mongoid documentation
class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  # Converts an object of this instance into a database friendly value.
  def mongoize
    [ x, y ]
  end

  class << self

    # Get the object as it was stored in the database, and instantiate
    # this custom class from it.
    def demongoize(object)
      Point.new(object[0], object[1])
    end

    # Takes any possible object and converts it to how it would be
    # stored in the database.
    def mongoize(object)
      case object
      when Point then object.mongoize
      when Hash then Point.new(object[:x], object[:y]).mongoize
      else object
      end
    end

    # Converts the object that was supplied to a criteria and converts it
    # into a database friendly form.
    def evolve(object)
      case object
      when Point then object.mongoize
      else object
      end
    end
  end
end