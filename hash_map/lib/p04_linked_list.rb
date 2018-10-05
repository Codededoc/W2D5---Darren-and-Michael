require "byebug"

class Node

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.next.prev = self.prev
    self.prev.next = self.next
    self.prev, self.next = nil, nil
  end
end

class LinkedList
  attr_reader :head, :tail, :nodes

  include Enumerable

  def initialize
    @head = Node.new(:sentinel, "head")
    @tail = Node.new(:sentinel, "tail")
    self.head.next = self.tail
    self.tail.prev = self.head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
    current_node = self.head
    until current_node == self.tail
      if current_node.key == key
        return current_node.val
      end
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    current_node = self.head
    until current_node == self.tail
      if current_node.key == key
        return true
      end
      current_node = current_node.next
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    last_node_before_append = self.tail.prev
    last_node_before_append.next = new_node
    self.tail.prev = new_node
    new_node.next = self.tail
    new_node.prev = last_node_before_append
  end

  def update(key, val)
    # go through node, with #next, starting with head, until we find
    # the node with the same key, update this same_key node's value with
    # provided val argument
    current_node = self.head
    until current_node == self.tail
      if current_node.key == key
        current_node.val = val
        return
      end
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = self.head
    until current_node == self.tail
      if current_node.key == key
        current_node.remove
        return
      end
      current_node = current_node.next
    end

  end


  def each(&prc)
    current_node = first
    until current_node == self.tail
      prc.call(current_node)
      current_node = current_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
