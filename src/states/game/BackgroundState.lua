BackgroundState = Class{__includes = PlayState}

function BackgroundState:init(levelNum)
    local level = generateLevel(3)
    gPoints = level.points

    nodeNumbers = {}
    for i = 1, #gPoints do
        table.insert(nodeNumbers, i)
    end

    self.graph = Graph(nodeNumbers)
    self.cycles = {}

    self:updateAvailableEdges()
    while #self.availableEdges > 0 do
        edge = self.availableEdges[math.random(1, #self.availableEdges)]
        self.graph:add_edge(edge[1], edge[2])
        self:updateAvailableEdges()
    end
    self.cycles = minimum_cycle_basis(self.graph)

    local colors = {}
    for i = 1, 10 do
        table.insert(colors, {math.random(1, 255), math.random(1, 255), math.random(1, 255), 200})
    end

    self.colorAllocation = {}
    for i, c in pairs(self.cycles) do
        self.colorAllocation[c] = colors[math.random(#colors)]
    end
    self.backgroundColor = colors[math.random(#colors)]
end

function BackgroundState:updateAvailableEdges()
    self.availableEdges = {}
    for n1 = 1, #gPoints do
        for n2 = n1 + 1, #gPoints do
            if n1 ~= n2 and self:validLine({n1, n2}) then
                table.insert(self.availableEdges, {n1, n2})
            end
        end 
    end
end

function BackgroundState:render()
    love.graphics.clear(255, 255, 255, 255)

    for i, cycle in pairs(self.cycles) do
        love.graphics.setColor(self.colorAllocation[cycle])
        local vertices = getVertices(cycle)
        if convex then
            love.graphics.polygon('fill', vertices)
        else
            triangles = love.math.triangulate(vertices)
            for i, polygon_triangle in pairs(triangles) do
                love.graphics.polygon('fill', polygon_triangle)
            end
        end
    end

    love.graphics.setColor(0, 0, 0)

    shiftX = 100
    shiftY = gFonts['medium']:getHeight()

    for i, line in pairs(self.graph.edges) do
        love.graphics.line(gPoints[line[1]][1], gPoints[line[1]][2], gPoints[line[2]][1], gPoints[line[2]][2])
    end

    for i, point in pairs(gPoints) do
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
