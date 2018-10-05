class MaxIntSet
# time complexity:
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    self.store[num] = true
  end

  def remove(num)
    self.store[num] = false
  end

  def include?(num)
    self.store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, self.max)
    #num => min && num <= max  ==> constant
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
    # 1. modifies receiver
    # 2. indicates method may raise error
  end
end


class IntSet

  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return if self.include?(num) # => O(N) time complexity
    self[num] << num # => O(1) time complexity
  end

  def remove(num)
    return unless self.include?(num) # => O(N) time complexity
    self[num].delete(num) # => O(N) time complexity

  end

  def include?(num)
    self[num].include?(num) # where the main include? O(N) time complexity comes from
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % num_buckets #=> O(1)
    self.store[index] #=> O(1)
  end

  def num_buckets
    self.store.length
  end
end

class ResizingIntSet #=> O(N^2)
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num) #=> O(N^2)
    resize! if self.count == num_buckets
    return if self.include?(num)
    self[num] << num
    self.count += 1
  end

  def remove(num) #=> O(N)
    return unless self.include?(num)
    self[num].delete(num)
    self.count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    index = num % num_buckets
    self.store[index]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    self.store.length
  end

  def resize! #=> O(N^2)
    elements = self.store.flatten
    self.count = 0
    self.store = Array.new(num_buckets + num_buckets) { Array.new }
    elements.each { |ele| insert(ele) }

  end
end

# O(N) or O(1)?
