
def my_min_slow(arr)
    arr.each.with_index do |ele1, i|
        is_smallest = true
        arr.each do |ele2|
            is_smallest = false if ele2 < ele1
        end
        return ele1 if is_smallest
    end
end

def my_min_fast(arr)
    is_smallest = arr[0]
    (1...arr.length).each do |i|
        is_smallest = arr[i] if is_smallest > arr[i]
    end
    is_smallest
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min_slow(list)  # =>  -5
# p my_min_fast(list)  # =>  -5


def largest_contiguous_subsum_slow(list) # O(n^3)
    largest = list[0]
    list.each.with_index do |ele1, i|
        arr = [ele1]
        largest = arr.sum if arr.sum > largest
        (i + 1...list.length).each do |j|
            arr << list[j]
            largest = arr.sum if arr.sum > largest
        end
    end
    largest
end

# def largest_contiguous_subsum_fast(list)    # O(n)
#     largest_sum = list[0]
#     current_sum = 0
#     subtract_sum = 0
#     j = -2
#     list.each.with_index do |ele, i|
#         current_sum += ele
#         largest_sum = current_sum if current_sum > largest_sum
#         largest_sum = ele if ele > largest_sum
#         largest_sum = (current_sum - subtract_sum) if (current_sum - subtract_sum) > largest_sum

#         if j > -1
#             subtract_sum += list[j]
#             largest_sum = (current_sum - subtract_sum) if (current_sum - subtract_sum) > largest_sum
#         end
#         j += 1
#         # p largest_sum
#     end
#     largest_sum
# end

def largest_contiguous_subsum_fast(list)
    largest_sum = list[0]
    current_sum = list[0]
    list.each.with_index do |ele, i|
        if i != 0
            current_sum = 0 if current_sum < 0
            current_sum += ele
            largest_sum = current_sum if largest_sum < current_sum
        end
    end
    largest_sum
end

list = [2, -13, 6, 7, -6, 7]
p largest_contiguous_subsum_fast(list) # => 14
list = [-5, -1, -3]
p largest_contiguous_subsum_fast(list) # => -1 (from [-1])