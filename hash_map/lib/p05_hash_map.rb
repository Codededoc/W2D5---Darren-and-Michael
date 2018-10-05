require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return false if get(key).nil?
    true
  end

  def set(key, val)
    resize! if self.count == num_buckets
    if self.include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      self.count -= 1
    end
  end

  def each(&prc)
    self.store.each do |ll|
      ll.each do |node|
        prc.call(node.key, node.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    self.count = 0
    new_hash_map = HashMap.new(num_buckets + num_buckets)
    self.each { |k,v| new_hash_map.set(k, v) }
    self.store = new_hash_map.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    self.store[key.hash % num_buckets]
  end
end
