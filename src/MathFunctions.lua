--[[
    Returns the length between two points on a 2D plane
]]
function point_length(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

function slope(line)
    return (line[2][2] - line[1][2]) / (line[2][1] - line[1][1])
end

function isSubsetOf(t1, t2)
    for i,v1 in pairs(t2) do
        if not table.contains(t1, v1) then
            return false
        end
    end
    return true
end

function lines_intersect(line1, line2, endpoints)
    endpoints = endpoints or false
    m1 = slope(line1)
    m2 = slope(line2)
    c1 = line1[2][2] - m1 * line1[2][1]
    c2 = line2[2][2] - m2 * line2[2][1]

    if m1 == m2 and c1 == c2 and m1 ~= 0 and math.abs(m1) ~= math.huge then
        return false
    end

    p0_x = line1[1][1]
    p0_y = line1[1][2]

    p1_x = line1[2][1]
    p1_y = line1[2][2]

    p2_x = line2[1][1]
    p2_y = line2[1][2]

    p3_x = line2[2][1]
    p3_y = line2[2][2]

    s1_x = p1_x - p0_x
    s1_y = p1_y - p0_y
    s2_x = p3_x - p2_x
    s2_y = p3_y - p2_y

    s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y)
    t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y)

    if endpoints then
        if (s >= 0 and s <= 1 and t >= 0 and t <= 1) then
            return true
        end
    else
        if (s > 0 and s < 1 and t >= 0 and t <= 1) then
            return true
        end
    end

    return false

end

function sameElements(t1, t2)
    return isSubsetOf(t1, t2) and isSubsetOf(t2, t1)
end
