def my_uniq(arr)
    hash = Hash.new(0)
    arr.each do |val|
        hash[val] += 1
    end
    array = []
    hash.each do |key, val|
        array << key
    end
    array
end

def two_sum(arr)
    array = []
    i = 0
    while i < arr.length
        j = i + 1
        while j < arr.length
            array << [i, j] if arr[i] + arr[j] == 0
            j += 1
        end
        i += 1
    end
    array
end
#[ [0, 1, 2], [3, 4, 5], [6, 7, 8]]
# [[0, 3, 6], [1, 4, 7], [2, 5, 8]] 
def my_transpose(arr)
    newArr = Array.new(arr.length) {Array.new(arr.length)}
    arr.each.with_index do |row, i|
        row.each.with_index do |value, j|
            newArr[j][i] = arr[i][j]
        end
    end
    newArr
end

# [1, 2, 3, 4]

# [1, 2]
# [1, 3]
# [1, 4]
# [2, 3]
# [2, 3]
# [3, 4]

def stock_picker(array)
    # max of (max val - min val) where max val.index > min val.index
   max_difference = 0
   pair = []
   i = 0
   while i < array.length 
        j = i + 1
        while j < array.length
            if array[j] - array[i] > max_difference
                max_difference = array[j] - array[i] 
                pair = [i, j]
            end
            j += 1
        end
        i += 1
    end
    pair
end 