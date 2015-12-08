class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def to_s
  	"#{name}"
  end
end
