GameOverState = Class{__includes = BaseState}

function GameOverState:init(winningPlayer, players)
    self.winningPlayer = winningPlayer
    self.players = players

    self.width = VIRTUAL_WIDTH/2

    local y = 10 + gFonts['medium-bigger']:getHeight() + 90
    for i,player in pairs(self.players) do
        y = y + 10 + gFonts['medium']:getHeight() + gFonts['small']:getHeight() + 20
    end

    self.height = y

    self.x = 0 + self.width/2
    self.y = -self.height
    self.exitable = false
    Timer.tween(2, {
        [self] = {y = (VIRTUAL_HEIGHT - self.height)/2},
    }):finish(function() self.exitable = true end)
end

function GameOverState:update(dt)
    if self.exitable and love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:pop()
        gStateStack:push(StartState())
    end
end

function GameOverState:render()
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(245, 245, 245, 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 10)

love.graphics.setColor(0, 0, 0, 255)
    love.graphics.setFont(gFonts['medium-bigger'])
    love.graphics.printf('Player ' .. tostring(self.winningPlayer) .. ' wins!', self.x, self.y + 10, self.width, 'center')

    -- love.graphics.setFont(gFonts['small'])
    -- love.graphics.printf('Points: ' .. tostring(self.players[self.winningPlayer].points), self.x, self.y + 10 + gFonts['medium-bigger']:getHeight(), self.width, 'center')
    -- love.graphics.printf('Area: ' .. tostring(self.players[self.winningPlayer].pentagonArea), self.x, self.y + 10 + gFonts['medium-bigger']:getHeight() + gFonts['small']:getHeight(), self.width, 'center')

    local y = self.y + 10 + gFonts['medium-bigger']:getHeight() + 20
    for i,player in pairs(self.players) do
        love.graphics.setFont(gFonts['medium'])
        love.graphics.printf('Player ' .. tostring(i), self.x, y + 10, self.width, 'center')

        love.graphics.setFont(gFonts['small'])
        love.graphics.printf('Points: ' .. tostring(self.players[i].points), self.x, y + 10 + gFonts['medium']:getHeight(), self.width, 'center')
        love.graphics.printf('Area: ' .. tostring(self.players[i].pentagonArea), self.x, y + 10 + gFonts['medium']:getHeight() + gFonts['small']:getHeight(), self.width, 'center')
        y = y + 10 + gFonts['medium']:getHeight() + gFonts['small']:getHeight() + 20
    end

    y = y + 20
    love.graphics.printf("Press 'Enter' to return to menu", self.x, y + 20, self.width, 'center')
end
