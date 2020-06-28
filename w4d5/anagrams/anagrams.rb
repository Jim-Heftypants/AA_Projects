def first_anagram(first, second)
    first = first.split("")
    first = first.permutation.to_a
    first.include?(second.split(""))
end

def second_anagram(first, second)
    first.each_char do |char|
       second.delete!(char)
    end
    second.empty?
end

def third_anagram(first, second)
    first = first.split("").sort
    second = second.split("").sort
    first == second
end

def fourth_anagram(first, second)
    first_hash = Hash.new(0)
    second_hash = Hash.new(0)

    first.each_char.with_index do |char, i|
        first_hash[first[i]] += 1
        second_hash[second[i]] += 1
    end

    first_hash == second_hash
end

def fifth_anagram(first, second)
    hash = Hash.new(0)

    first.each_char.with_index do |char, i|
        hash[char] += 1
        hash[second[i]] += 1
    end

    hash.each do |char, times|
        return false if !(times % 2 == 0)
    end
    true
end

# p first_anagram("gizmo", "sally")    #=> false
# p second_anagram("gizmo", "sally")    #=> false
# p third_anagram("gizmo", "sally")    #=> false
p fifth_anagram("gizmo", "sally")    #=> false

# p first_anagram("elvis", "lives")    #=> true
# p second_anagram("elvis", "lives")    #=> true
# p third_anagram("elvis", "lives")    #=> true
p fifth_anagram("elvis", "lives")    #=> true