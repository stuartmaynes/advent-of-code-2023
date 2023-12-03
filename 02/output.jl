input = readlines("./02/input.txt")

allowed = Dict("red" => 12, "blue" => 14, "green" => 13)

function is_valid_game(game)
    for (color, score) in game
        if score > allowed[color]
            return false
        end
    end
    true
end

function games_as_dict(game)
    scores = Int[]
    colors = String[]

    for n in range(start=1, stop=length(game), step=2)
        push!(scores, tryparse(Int, game[n]))
        push!(colors, game[n+1])
    end

    return Dict(zip(colors, scores))
end

function fewest_cubes_for_a_valid_game(game)
    sets = Dict("blue" => 0, "red" => 0, "green" => 0)

    for subset in game
        for (key, value) in subset
            sets[key] = max(sets[key], value)
        end
    end

    return sets
end

function powers_of_set(set)
    total = 1
    for (k, value) in set
        total = total * value
    end
    return total
end

function possible_games(games)
    possible = Int[]
    powers = Int[]

    for game in games
        count = 0
        sets = []

        id, draws = split(game, ": ")

        id = tryparse(Int, replace(id, "Game " => ""))

        subsets = split(draws, "; ")

        for set in subsets
            game = split(replace(set, "," => ""), " ")
            game = games_as_dict(game)
            push!(sets, game)

            if is_valid_game(game)
                count += 1
            end
        end

        x = fewest_cubes_for_a_valid_game(sets)
        push!(powers, powers_of_set(x))

        if count == length(subsets)
            push!(possible, id)
        end
    end

    return possible, powers
end

a, b = possible_games(input)

println(sum(a))
println(sum(b))
