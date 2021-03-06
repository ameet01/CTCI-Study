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
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = @head
    until node == @tail
      return node.next.val if node.next.key == key
      node = node.next
    end
    return nil
  end

  def include?(key)
    # node = @head
    # until node == @tail
    #   return true if node.next.key == key
    #   node = node.next
    # end
    # return false
    self.any? { |node| node.key == key }
  end

  def append(key, val)
    new_node = Node.new(key, val)

    new_node.prev = @tail.prev
    @tail.prev.next = new_node

    @tail.prev = new_node
    new_node.next = @tail

    return new_node
  end

  def update(key, val)
    node = @head
    until node.next == @tail
      if node.next.key == key
        node.next.val = val
        return key
      end
      node = node.next
    end
    return nil
  end

  def remove(key)
    node = @head
    until node.next == @tail
      if node.next.key == key
        node.next.next.prev = node
        node.next = node.next.next
        return key
      end
      node = node.next
    end
    return nil
  end

  def each
    node = @head.next
    until node == @tail
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
