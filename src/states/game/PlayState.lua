PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.points = {
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
        {9 / 10 * VIRTUAL_WIDTH, 9 / 12 * VIRTUAL_HEIGHT},
    }

    self.lines = {}

    for i = 1, #self.points, 2 do
        table.insert(self.lines, {i, i + 1})
    end

    self.selected = nil
end

function PlayState:validLine(line1)
    for i, line2 in pairs(self.lines) do
        if (line1[1] == line2[1] and line1[2] == line2[2]) or (line1[2] == line2[1] and line1[1] == line2[2]) then
            return false
        end
        coordinateLine1 = deepcopy({self.points[line1[1]], self.points[line1[2]]})
        coordinateLine1[1][2] = - coordinateLine1[1][2]
        coordinateLine1[2][2] = - coordinateLine1[2][2]

        coordinateLine2 = deepcopy({self.points[line2[1]], self.points[line2[2]]})
        coordinateLine2[1][2] = - coordinateLine2[1][2]
        coordinateLine2[2][2] = - coordinateLine2[2][2]

        if lines_intersect(coordinateLine1, coordinateLine2) then
            return false
        end
    end
    return true
end

function PlayState:update(dt)
    mouseX, mouseY = push:toGame(love.mouse.getX(), love.mouse.getY())
    if love.mouse.keysPressed[1] then
        if self.selected then
            local other = nil
            for i, point in pairs(self.points) do
                if point_length(mouseX, mouseY, point[1], point[2]) <= POINT_HITBOX then
                    other = i
                end
            end
            if other and self.selected ~= other then
                -- at this point
                if self:validLine({self.selected, other}) then
                    table.insert(self.lines, {self.selected, other})
                else
                    gSounds['deny-connection']:play()
                    -- graphics to show line and then fade it out
                end
            end
            self.selected = nil
        else
            for i, point in pairs(self.points) do
                if point_length(mouseX, mouseY, point[1], point[2]) <= POINT_HITBOX then
                    self.selected = i
                end
            end
        end
    end
end

function PlayState:render()
    love.graphics.clear(255, 255, 255, 255)
    love.graphics.setColor(0, 0, 0)

    for i, line in pairs(self.lines) do
        love.graphics.line(self.points[line[1]][1], self.points[line[1]][2], self.points[line[2]][1], self.points[line[2]][2])
    end

    for i, point in pairs(self.points) do
        if self.selected == i then
            love.graphics.setColor(255, 0, 0)
        else
            love.graphics.setColor(0, 0, 0)
        end
        love.graphics.circle('fill', point[1], point[2], 5)
    end
end
