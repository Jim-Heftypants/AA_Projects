class MaxIntSet
  attr_reader :store, :max
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    raise 'Out of bounds' if num > @max || num < 0
    @store[num] = true
  end
  
  def remove(num)
    @store[num] = false if include?(num)
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % 20] = num
  end

  def remove(num)
    @store.delete_at(num % 20) if self.include?(num)
  end

  def include?(num) 
    return true if @store[num % 20] == num
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 20)
    @num_buckets = 20
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !@store.include?(num)
      @store[num % @num_buckets] = num 
      @count += 1
      if @count % 20 == 0
        resize!
      end
    end
  end

  def remove(num)
    if @store.include?(num)
      @store.delete_at(num % @num_buckets)
      @count -= 1
    end 
    
  end

  def include?(num)
    return true if @store[num % @num_buckets] == num 
    false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count % 20 == 0
      # 20, 40, 60
      @num_buckets *= 2
      new_store = Array.new(@num_buckets)
      @store.each do |num|
        new_store[num % @num_buckets] = num
      end
      @store = new_store
    end
  end
end
