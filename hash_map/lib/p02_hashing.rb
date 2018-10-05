class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    each_with_index {|el,i| result += el.hash ^ i.hash }
    result
  end
end

class String
  def hash
    result = 0
    each_byte.with_index { |byte, i| result += byte.hash ^ i.hash }
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    each {|k,v| result += k.hash ^ v.hash}
    result
  end
end
