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

function Graph:add_edge(edge)
    table.insert(self.nodes_adj[edge[1]], edge[2])
    table.insert(self.nodes_adj[edge[2]], edge[1])
    table.insert(self.edges, edge)
end

function Graph:find_cycles()
    self.mark = {}
    self.color = {}
    self.par = {}
    self.cyclenumber = {}
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

    for i, v in self.nodes_adj[u] do
        if v ~= self.par[u] then
            self:dfs_cycle(v, u)
        end
    end

    self.color[u] = 2
end
