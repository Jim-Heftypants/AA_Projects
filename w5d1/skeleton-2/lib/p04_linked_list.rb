class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
  end

  def last
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    current_node = @head 
    until current_node.next == nil 
      if current_node.key == key 
        return current_node.val
      end
    end
    return nil
  end

  def include?(key)
  end

  def append(key, val)
    # new node
    node = Node.new(key, val)

    # nil 3 5 6 nil
    # add node 2
    # 2<=3
    # 2=>3
    # nil=>2
    # 1<=nil
    # nil-2-3

    @tail.prev.next = node
    node.prev = @tail.prev
    @tail.prev = node
    node.next = @tail

    # @head.next.prev = node
    # node.next = @head.next
    # @head.next = node
    # node.prev = @head
  end

  def update(key, val)
  end

  def remove(key)
    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
      if current_node.key == key
        current_node.prev.next = current_node.next
        current_node.next.prev = current_node.prev
        return key
      end
    end
  end

  def each
    arr = []
    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
      arr << current_node.val
    end
    arr
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
