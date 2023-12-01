lines = readlines("./01/input.txt")

function part_one(line)
    # Remove all characters except the digits from the string
    digits = replace(line, r"\D+" => "")
    # Combine the first and last character in the string
    number = string(first(digits), last(digits))
    # Parse the string to an integer
    return tryparse(Int, number)
end

function part_two(line)
    re = r"(\d|one|two|three|four|five|six|seven|eight|nine)"
    # Loop through each match and create a string that includes overlaps
    digits = join([m.captures[1] for m in eachmatch(re, line, overlap=true)])
    # Replace each instance of the words with their numerical representation
    digits = replace(digits, "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9")
    # Pass over to part one to extract the value
    return part_one(digits)
end

println(sum(part_one.(lines)))
println(sum(part_two.(lines)))
