class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if self.count == num_buckets
    return if self.include?(key)
    self[key] << key
    self.count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return unless self.include?(key)
    self[key].delete(key)
    self.count -= 1
  end

  private

  def [](num)
    index = num.hash % num_buckets
    self.store[index]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = self.store.flatten
    self.count = 0
    self.store = Array.new(num_buckets + num_buckets) {Array.new}
    elements.each { |ele| insert(ele) }
  end
end
