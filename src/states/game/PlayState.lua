PlayState = Class{__includes = BaseState}

function PlayState:init()
    gPoints = {
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

    local nodeNumbers = {}
    for i=1,#gPoints do
        table.insert(nodeNumbers, i)
    end

    self.cycles = {}

    self.graph = Graph(nodeNumbers)
    self.graph.points = gPoints

    for i = 1, #self.graph.points, 2 do
        self.graph:add_edge(i, i + 1)
        -- table.insert(self.lines, {i, i + 1})
    end

    self.selected = nil
end

function PlayState:validLine(line1)
    for i, line2 in pairs(self.graph.edges) do
        if (line1[1] == line2[1] and line1[2] == line2[2]) or (line1[2] == line2[1] and line1[1] == line2[2]) then
            return false
        end
        coordinateLine1 = deepcopy({self.graph.points[line1[1]], self.graph.points[line1[2]]})
        coordinateLine2 = deepcopy({self.graph.points[line2[1]], self.graph.points[line2[2]]})

        if lines_intersect(coordinateLine1, coordinateLine2) then
            return false
        end
    end

    for i,cycle in pairs(self.cycles) do
        if table.contains(cycle, line1[1]) and table.contains(cycle, line1[2]) then
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
            for i, point in pairs(self.graph.points) do
                if point_length(mouseX, mouseY, point[1], point[2]) <= POINT_HITBOX then
                    other = i
                end
            end
            if other and self.selected ~= other then
                -- at this point
                if self:validLine({self.selected, other}) then
                    self.graph:add_edge(self.selected, other)
                    -- table.insert(self.graph.edges, {self.selected, other})
                else
                    gSounds['deny-connection']:play()
                    -- graphics to show line and then fade it out
                end
            end
            self.selected = nil
        else
            for i, point in pairs(self.graph.points) do
                if point_length(mouseX, mouseY, point[1], point[2]) <= POINT_HITBOX then
                    self.selected = i
                end
            end
        end
        self.cycles = self.graph:find_cycles()
        print(tostring(#self.cycles) .. " primitive polygons")
        print_r(self.cycles)
    end
end

function PlayState:render()
    love.graphics.clear(255, 255, 255, 255)

    for i,cycle in pairs(self.cycles) do
        if #cycle == 5 then
            love.graphics.setColor(255, 0, 0, 200)
        else
            love.graphics.setColor(194, 197, 204, 200)
        end
        local vertices = getVertices(cycle)
        if convex then
            love.graphics.polygon('fill', vertices)
        else
            triangles = love.math.triangulate(vertices)
            for i,polygon_triangle in pairs(triangles) do
                love.graphics.polygon('fill', polygon_triangle)
            end
        end
    end

    love.graphics.setColor(0, 0, 0)

    for i, line in pairs(self.graph.edges) do
        love.graphics.line(self.graph.points[line[1]][1], self.graph.points[line[1]][2], self.graph.points[line[2]][1], self.graph.points[line[2]][2])
    end

    for i, point in pairs(self.graph.points) do
        if self.selected == i then
            love.graphics.setColor(255, 0, 0)
        else
            love.graphics.setColor(0, 0, 0)
        end
        love.graphics.setFont(gFonts['small'])
        love.graphics.print(tostring(i), point[1], point[2])
        love.graphics.circle('fill', point[1], point[2], 5)
    end
end
