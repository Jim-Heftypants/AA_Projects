class HashSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !@store.include?(key)
      @store[key.hash % @num_buckets] = key
      @count += 1
      if @count % @num_buckets == 0
        resize!
      end
    end
  end

  def include?(key)
    return true if key == [] && @store[key.hash % @num_buckets].object_id == key.object_id
    return true if @store[key.hash % @num_buckets] == key
    false 
  end

  def remove(key)
    if @store.include?(key)
      @store.delete_at(key.hash % @num_buckets)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count % num_buckets == 0
      # 20, 40, 80, ... , 20n
      @num_buckets *= 2
      new_store = Array.new(@num_buckets)
      @store.each do |num|
        new_store[num.hash % @num_buckets] = num
      end
      @store = new_store
    end
  end
end
