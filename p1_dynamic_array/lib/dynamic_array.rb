require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    self.store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    self.store[index] = value
    self.length += 1
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0
    self.length -= 1
  end


  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if self.length == self.capacity
      resize!
    else
      self.store[self.length] = val
      self.length += 1
    end
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if self.length == 0

    (0...self.length).each do |num|
      self.store[num] = self.store[num + 1]
    end

    self.length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if self.length == self.capacity
      resize!
    else
      self.length += 1
      count = self.length
      while count > 0
        self.store[count] = self.store[count - 1]
        count -= 1
      end
      self.store[0] = val
    end
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index > self.length - 1
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity *= 2
  end
end
