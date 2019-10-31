--[[

    October 2019
    Vishnu Nittoor
]]

-- Class = require 'lib/class'
-- require 'src/Util'

Graph = Class{}

function Graph:init(nodes)
    self.nodes = nodes

    self.nodes_adj = {}
    for i, node in pairs(self.nodes) do
        self.nodes_adj[node] = {}
    end

    self.edges = {}
end

function Graph:add_node(node)
    table.insert(self.nodes, node)
    self.nodes_adj[node] = {}
end

function Graph:add_edge(src, dest)
    table.insert(self.nodes_adj[src], dest)
    table.insert(self.nodes_adj[dest], src)
    table.insert(self.edges, {src, dest})
end

function shouldInsert(cycles, cycle_path)
    for i, cycle in pairs(cycles) do
        if sameElements(cycle, cycle_path) then
            return false
        end
    end
    return true
end

function lines_set(cycle)
    lines = {{cycle[1], cycle[#cycle]}, }
    for i = 1, #cycle - 1 do
        table.insert(lines, {cycle[i], cycle[i + 1]})
    end
    return lines
end

function points_set(cycle)
    pset = {{}, {}}
    for i = 1, #cycle do
        table.insert(pset[1], gPoints[cycle[i]][1])
        table.insert(pset[2], gPoints[cycle[i]][2])
    end
    return pset
end

function addPolygons(c1, c2)
    l1 = lines_set(c1)
    l2 = lines_set(c2)
    l3 = {}

    for i, e in pairs(l1) do
        if not(table.contains(l2, e) or table.contains(l2, {e[2], e[1]})) then
            table.insert(l3, e)
        end
    end

    for i, e in pairs(l2) do
        if not(table.contains(l1, e) or table.contains(l1, {e[2], e[1]})) then
            table.insert(l3, e)
        end
    end

    return l3
end

function additiveProperty(c1, c2, c3)
    l3_add = addPolygons(c1, c2)
    l3 = lines_set(c3)

    for i, v1 in pairs(l3_add) do
        if not (table.contains(l3, v1) or table.contains(l3, {v1[2], v1[1]})) then
            return false
        end
    end

    for i, v1 in pairs(l3) do
        if not (table.contains(l3_add, v1) or table.contains(l3_add, {v1[2], v1[1]})) then
            return false
        end
    end

    return true
end

function shoelace(pset)
    n = #pset[1]
    x = pset[1]
    y = pset[2]
    accumulator = x[n] * y[1] - x[1] * y[n]
    for i = 1, n - 1 do
        accumulator = accumulator + x[i] * y[i + 1]
    end
    for i = 1, n - 1 do
        accumulator = accumulator - x[i + 1] * y[i]
    end
    return math.abs(accumulator) / 2
end

function highestArea(c1, c2, c3)
    c1_area = shoelace(points_set(c1))
    c2_area = shoelace(points_set(c2))
    c3_area = shoelace(points_set(c3))
    if c1_area > c2_area and c1_area > c3_area then
        return c1
    elseif c2_area > c1_area and c2_area > c3_area then
        return c2
    else
        return c3
    end
end

function getVertices(cycle)
    local vertices = {}
    for j, nodeNumber in pairs(cycle) do
        vertices = table.concatenate(vertices, gPoints[nodeNumber])
    end
    return vertices
end

function pointInPolygon(point, vertices)
    poly = {}

    for i = 1, #vertices - 1, 2 do
        table.insert(poly, {vertices[i], vertices[i + 1]})
    end

    n = #poly
    inside = false
    x = point[1]
    y = point[2]
    p1x = poly[1][1]
    p1y = poly[1][2]
    for i = 0, n do
        p2x = poly[(i % n) + 1][1]
        p2y = poly[(i % n) + 1][2]
        -- print((i % n) + 1)
        if y > math.min(p1y, p2y) then
            if y <= math.max(p1y, p2y) then
                if x <= math.max(p1x, p2x) then
                    if p1y ~= p2y then
                        xints = (y - p1y) * (p2x - p1x) / (p2y - p1y) + p1x
                    end
                    if p1x == p2x or x <= xints then
                        inside = not inside
                    end
                end
            end
        end
        p1x = p2x
        p1y = p2y
    end

    return inside
end

function midpoint(p1, p2)
    return {(p1[1]+p2[1])/2, (p1[2]+p2[2])/2}
end

function Graph:find_cycles()
    local paths = self:find_paths()
    local cycles = {}
    for n, path in pairs(paths) do
        isCycle = false
        cycle_path = {}
        for i = #path - 1, 1, - 1 do
            table.insert(cycle_path, path[i])
            if path[i] == path[#path] then
                isCycle = true
                break
            end
        end
        if shouldInsert(cycles, cycle_path) and isCycle then
            table.insert(cycles, cycle_path)
        end
    end

    local remove = {}

    for i, c in pairs(cycles) do
        for i, e in pairs(self.edges) do
            l = lines_set(c)
            v = getVertices(c)
            p1 = gPoints[e[1]]
            p2 = gPoints[e[2]]
            e1_inside = table.contains(c, e[1])
            e2_inside = table.contains(c, e[2])
            -- if not(e1_inside and e2_inside) and not (table.contains(l, e) or table.contains(l, {e[2], e[1]})) and pointInPolygon(midpoint(p1, p2), v) then
            --     print("yes")
            --     print_r(e)
            --     print_r(c)
            --     table.insert(remove, c)
            --     break
            -- elseif (pointInPolygon(p1, v) and not(e1_inside)) or (pointInPolygon(p2, v) and not(e2_inside)) then
            --     print("oh well")
            --     print(e)
            --     print_r(c)
            --     table.insert(remove, c)
            --     break
            -- end

            if not (table.contains(l, e) or table.contains(l, {e[2], e[1]})) and pointInPolygon(midpoint(p1, p2), v) then
                print("yes")
                print_r(e)
                print_r(c)
                table.insert(remove, c)
                break
            end
        end
    end

    -- Checks every triplet of cycles
    -- for i, c1 in pairs(cycles) do
    --     for j, c2 in pairs(cycles) do
    --         for k, c3 in pairs(cycles) do
    --             if c1 == c2 or c1 == c3 or c2 == c3 then
    --                 goto continue
    --             end
    --
    --             -- print("CYCLES UPCOMING ")
    --             -- print_r(c1)
    --             -- print_r(c2)
    --             -- print_r(c3)
    --             -- print_r(addPolygons(c1, c2))
    --             -- print_r(additiveProperty(c1,c2,c3))
    --
    --             if additiveProperty(c1, c2, c3) then
    --                 table.insert(remove, highestArea(c1, c2, c3))
    --             end
    --
    --             ::continue::
    --         end
    --     end
    -- end

    local primitiveCycles = {}

    for i, c in pairs(cycles) do
        if not table.contains(remove, c) then
            table.insert(primitiveCycles, c)
        end
    end

    -- if remove then
    --     print('removing')
    --     print_r(remove)
    --     table.removeElements(cycles, remove)
    -- end

    return primitiveCycles
end

function Graph:dfs_cycle(u, p)
    if self.color[u] == 2 then
        return nil
    end

    if self.color[u] == 1 then
        self.cyclenumber = self.cyclenumber + 1
        local cur = p
        self.mark[cur] = self.cyclenumber

        while cur ~= u do
            cur = self.par[cur]
            self.mark[cur] = self.cyclenumber
        end
        return nil
    end

    self.par[u] = p

    self.color[u] = 1

    for i, v in pairs(self.nodes_adj[u]) do
        -- print(v)
        if v ~= self.par[u] then
            self:dfs_cycle(v, u)
        end
    end

    self.color[u] = 2
end

function Graph:find_paths_from_root(root, pList)
    --[[
    Finds all paths from the root node to a leaf node, or a node already contained in the path.
    ]]
    -- print_r(pList)
    self.explored[root] = true
    local newPlist = deepcopy(pList)
    if #self.nodes_adj[root] == 1 and #pList ~= 0 then
        table.insert(newPlist, root)
        return deepcopy({newPlist})
    end

    L = {}
    for i, k in pairs(self.nodes_adj[root]) do
        self.explored[k] = true
        if pList[#pList] == k then
            -- we're looking at the parent node
            goto continue
        end

        newPlist = deepcopy(pList)
        table.insert(newPlist, root)

        if table.contains(pList, k) then
            -- we're looking at a node that we've already seen in the parent list
            table.insert(newPlist, k)
            table.insert(L, newPlist)
        else
            -- go deeper!
            L = table.concatenate(L, self:find_paths_from_root(k, newPlist))
        end

        ::continue::
    end

    return L
end

function Graph:find_paths()
    self.explored = {}
    for i, node in pairs(self.nodes) do
        self.explored[node] = false
    end
    local explored = false

    L = {}
    unexplored_node = self.nodes[math.random(#self.nodes)]
    unexplored_node = 3

    while not explored do
        L = table.concatenate(L, self:find_paths_from_root(unexplored_node, {}))
        explored = true
        for node, isexplored in pairs(self.explored) do
            if not isexplored then
                unexplored_node = node
                explored = false
                break
            end
        end
    end

    return L
end

-- math.randomseed(os.time())
-- nodes = {1, 2, 3, 4, 5, 6, 7, 8}
-- G = Graph(nodes)
--
-- G:add_edge(1, 2)
-- G:add_edge(1, 8)
--
-- G:add_edge(2, 5)
-- G:add_edge(2, 7)
--
-- G:add_edge(7, 8)
-- G:add_edge(7, 6)
--
-- G:add_edge(5, 6)
-- G:add_edge(5, 3)
--
-- G:add_edge(3, 4)
--
-- for i = 1, 10 do
--     print('\n')
-- end
-- print_r(G.nodes_adj)
-- print_r(G:find_paths(1, {}))
