Player = Class{}

function Player:init(points, shapes)
    self.points = points
    self.shapes = shapes
    self.pentagonArea = 0
end

function Player:update(shapes)
    for i, c in pairs(shapes) do
        if #c == 3 then
            self.points = self.points + TRIANGLE_POINTS
        elseif #c == 4 then
            self.points = self.points + QUAD_POINTS
        elseif #c == 5 then
            self.points = self.points + PENTAGON_POINTS
            self.pentagonArea = self.pentagonArea + shoelace(points_set(c)) * (PIXEL_AREA_SCALE_FACTOR)
        elseif #c == 6 then
            self.points = self.points + HEXAGON_POINTS
        elseif #c == 7 then
            self.points = self.points + HEPTAGON_POINTS
        end
    end
end
