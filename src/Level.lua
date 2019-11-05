function generateLevel(n)
    print(n)
    local level = {
        ['points'] = {},
        ['edges'] = {}
    }
    if n == 1 then
        level = {
            ['points'] = {
                {2 / 10 * VIRTUAL_WIDTH, 1 / 6 * VIRTUAL_HEIGHT},
                {4 / 10 * VIRTUAL_WIDTH, 1 / 6 * VIRTUAL_HEIGHT},

                {6 / 10 * VIRTUAL_WIDTH, 1 / 6 * VIRTUAL_HEIGHT},
                {8 / 10 * VIRTUAL_WIDTH, 1 / 6 * VIRTUAL_HEIGHT},

                {2 / 10 * VIRTUAL_WIDTH, 5 / 6 * VIRTUAL_HEIGHT},
                {4 / 10 * VIRTUAL_WIDTH, 5 / 6 * VIRTUAL_HEIGHT},

                {6 / 10 * VIRTUAL_WIDTH, 5 / 6 * VIRTUAL_HEIGHT},
                {8 / 10 * VIRTUAL_WIDTH, 5 / 6 * VIRTUAL_HEIGHT},

                {1 / 10 * VIRTUAL_WIDTH, 3 / 12 * VIRTUAL_HEIGHT},
                {1 / 10 * VIRTUAL_WIDTH, 9 / 12 * VIRTUAL_HEIGHT},

                {5 / 10 * VIRTUAL_WIDTH, 3 / 12 * VIRTUAL_HEIGHT},
                {5 / 10 * VIRTUAL_WIDTH, 9 / 12 * VIRTUAL_HEIGHT},

                {9 / 10 * VIRTUAL_WIDTH, 3 / 12 * VIRTUAL_HEIGHT},
                {9 / 10 * VIRTUAL_WIDTH, 9 / 12 * VIRTUAL_HEIGHT}
            },
            ['edges'] = {
            }
        }
    elseif n == 2 then
        level = {
            ['points'] = {
                {2 / 8 * VIRTUAL_WIDTH, 1 / 8 * VIRTUAL_HEIGHT},
                {3 / 8 * VIRTUAL_WIDTH, 1 / 8 * VIRTUAL_HEIGHT},

                {5 / 8 * VIRTUAL_WIDTH, 1 / 8 * VIRTUAL_HEIGHT},
                {6 / 8 * VIRTUAL_WIDTH, 1 / 8 * VIRTUAL_HEIGHT},
                --

                {2 / 8 * VIRTUAL_WIDTH, 4 / 8 * VIRTUAL_HEIGHT},
                {3 / 8 * VIRTUAL_WIDTH, 4 / 8 * VIRTUAL_HEIGHT},

                {5 / 8 * VIRTUAL_WIDTH, 4 / 8 * VIRTUAL_HEIGHT},
                {6 / 8 * VIRTUAL_WIDTH, 4 / 8 * VIRTUAL_HEIGHT},
                --

                {2 / 8 * VIRTUAL_WIDTH, 7 / 8 * VIRTUAL_HEIGHT},
                {3 / 8 * VIRTUAL_WIDTH, 7 / 8 * VIRTUAL_HEIGHT},

                {5 / 8 * VIRTUAL_WIDTH, 7 / 8 * VIRTUAL_HEIGHT},
                {6 / 8 * VIRTUAL_WIDTH, 7 / 8 * VIRTUAL_HEIGHT},


                -- vertical bars
                {1 / 8 * VIRTUAL_WIDTH, 2 / 8 * VIRTUAL_HEIGHT},
                {1 / 8 * VIRTUAL_WIDTH, 3 / 8 * VIRTUAL_HEIGHT},

                {1 / 8 * VIRTUAL_WIDTH, 5 / 8 * VIRTUAL_HEIGHT},
                {1 / 8 * VIRTUAL_WIDTH, 6 / 8 * VIRTUAL_HEIGHT},


                {4 / 8 * VIRTUAL_WIDTH, 2 / 8 * VIRTUAL_HEIGHT},
                {4 / 8 * VIRTUAL_WIDTH, 3 / 8 * VIRTUAL_HEIGHT},

                {4 / 8 * VIRTUAL_WIDTH, 5 / 8 * VIRTUAL_HEIGHT},
                {4 / 8 * VIRTUAL_WIDTH, 6 / 8 * VIRTUAL_HEIGHT},


                {7 / 8 * VIRTUAL_WIDTH, 2 / 8 * VIRTUAL_HEIGHT},
                {7 / 8 * VIRTUAL_WIDTH, 3 / 8 * VIRTUAL_HEIGHT},

                {7 / 8 * VIRTUAL_WIDTH, 5 / 8 * VIRTUAL_HEIGHT},
                {7 / 8 * VIRTUAL_WIDTH, 6 / 8 * VIRTUAL_HEIGHT},
            },
            ['edges'] = {
            }
        }
    elseif n == NUM_LEVELS then
        nPoints = 20
        level = {
            ['points'] = {},
            ['edges'] = {}
        }
        for i = 1, nPoints do
            table.insert(level.points, {math.random(0, VIRTUAL_WIDTH), math.random(0, VIRTUAL_HEIGHT)})
        end

        return level
    end

    for i = 1, #level.points, 2 do
        table.insert(level.edges, {i, i + 1})
    end
    return level
end
