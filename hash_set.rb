# frozen_string_literal: true

require './linked_list'
require './node'

class HashSet
  attr_accessor :load_factor, :capacity

  def initialize(load_factor = 0.75)
    @load_factor = load_factor
    @capacity = 16
    @map = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key)
    index = get_index(key)
    return if has?(key)
    if (length + 1) > (@load_factor * @capacity)
      grow_hash_map
    end
    if @map[index].nil?
      @map[index] = start_list(key)
    else
      @map[index].append(key)
    end
  end

  # Irrelivant since the key is the only info held
  # def get(key)
  #   index = get_index(key)
  #   return nil unless @map[index]
  #   return nil if (l_i = @map[index].find(key)).nil?

  #   node = @map[index].at(l_i)
  #   node.value
  # end

  def has?(key)
    index = get_index(key)
    return false unless @map[index]
    return false unless @map[index].find(key)

    true
  end

  def remove(key)
    index = get_index(key)
    l_i = @map[index].find(key)
    if  l_i
      @map[index].remove_at(l_i)
    end
    key
  end

  def length
    index = 0
    count = 0
    while index < @map.length
      count += @map[index].size unless @map[index].nil?
      index += 1
    end
    count
  end

  def clear
    @map = []
  end

  def keys
    keys = []
      traverse_hash_map do |list|
        unless list.nil?
          list.traverse_list do |node|
            keys << node.value 
          end
        end
      end
    keys
  end

  private

  def start_list(key)
    list = LinkedList.new
    list.append(key)
    list
  end

  def get_index(key)
    hash(key) % @capacity
  end

  def traverse_hash_map
    index = 0
    while index < @map.length
      yield(@map[index])
      index += 1
    end
  end

  def grow_hash_map
    keys_array = keys
    @capacity *= 2
    clear
    keys_array.each {|key| set(key)} 
  end
end