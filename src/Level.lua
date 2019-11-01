function generateLevel(n)
    if n == 1 then
        return {
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
            ['figure_path'] = {1, 2, 3, 4, 13, 14, 8, 7, 6, 5, 10, 9}
        }
    elseif n == 2 then
        return {
            ['points'] = {
                -- horizontal bars
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

            ['figure_path'] = {1, 2, 3, 4, 21, 22, 23, 24, 12, 11, 10, 9, 16, 15, 14, 13}
        }
    end
end
