def two_sum_first(arr, tar)
    (0...arr.length).each do |i|
        (i+1...arr.length).each do |j|
            return true if arr[i] + arr[j] == tar
        end
    end
    false
end

arr = [0, 1, 5, 7]
# p two_sum_first(arr, 6) # => should be true
# p two_sum_first(arr, 10) # => should be false

class Array
    def merge_sort(&prc)
      prc = Proc.new { |x, y| x <=> y } if prc == nil
  
      return self if self.length < 2
  
      midpoint = count / 2
      sorted_left = self[0...midpoint].merge_sort(&prc)
      sorted_right = self[midpoint..-1].merge_sort(&prc)
  
      Array.merge(sorted_left, sorted_right, &prc)
    end
  
    private
    def self.merge(left, right, &prc)
      merged = []
  
      until left.empty? || right.empty?
        case prc.call(left[0], right[0])
        when -1
          merged << left.shift
        when 0
          merged << left.shift
          merged << right.shift
        when 1
          merged << right.shift
        end
      end
      merged += left + right
    end
end

def two_sum_second(arr, tar, is_sorted=false)  # O(nlog(n)) or O(log(n)^2)
    arr = arr.merge_sort if !is_sorted
    
    i = 0
    j = 0
    while i < arr.length
        p j
        p i 
        p "----"
        return true if arr[i] + arr[j] == tar
        if arr[i] + arr[j] > tar || (i == arr.length - 1 && j < arr.length - 1)
            j += 1
            i = j
        end
        i += 1
    end
    return false

    # arr = arr.merge_sort if !is_sorted
    # if arr.length < 3
    #     return false if arr.length == 1
    #     return (arr[0] + arr[1]) == tar
    # end

    # # [1, 2, 3, 4, 5], 4
    # # mid => 2
    # # sum => 5

    # # [1, 2, 3, 4, 5], 6
    # # mid => 2
    # # sum => 5

    # mid = arr.length / 2
    # sum = arr[mid - 1] + arr[mid]
    # case sum
    # when tar
    #     return true
    # when > tar
    #     ans = two_sum_second(arr[0...mid], tar, true)
    # when < tar
    #     ans = two_sum_second(arr[mid+1..-1], tar, true)
    # end
    # return ans
end

# p two_sum_second(arr, 6) # => should be true
# p two_sum_second(arr, 10) # => should be false

def two_sum_third(arr, tar)
    hash = Hash.new

    arr.each.with_index do |ele, i|
        

    end



end