class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return {}.hash if self == []
    my_hash = Hash.new
    self.each.with_index do |num, i|
      my_hash[i] = num.hash
    end
    self.object_id.hash
  end
end

class String
  def hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
