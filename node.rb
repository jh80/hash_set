# frozen_string_literal: true

# frozen_string_literal: true

# holds value and point to a next node
class Node
  attr_accessor :next_node
  attr_reader :value

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end
