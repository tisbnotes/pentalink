LevelSelectState = Class{__includes = BaseState}

function LevelSelectState:init()
    -- object data
    self.width = VIRTUAL_WIDTH / 4
    self.height = VIRTUAL_HEIGHT / 2

    self.x = (VIRTUAL_WIDTH - self.width) / 2
    self.y = (VIRTUAL_HEIGHT - self.height) / 2

    self.colors = {
        ['panel'] = {245, 245, 245, 0},
        ['background'] = {255, 255, 255, 0},
        ['text'] = {0, 0, 0, 0}
    }

    Timer.tween(0.25, {
        [self.colors['panel']] = {[4] = 255},
        [self.colors['text']] = {[4] = 255},
        [self.colors['background']] = {[4] = 100}
    })

    -- data about game
    self.data = {
        {
            ["arrowFunction"] = function(incr) end,
            ["enter"] = function()
                gStateStack:push(FadeInState({r = 255, g = 255, b = 255}, 0.2, function()
                    gStateStack:pop()
                    gStateStack:pop()
                    gStateStack:push(PlayState(self.data[2].value, self.data[3].value))
                    gStateStack:push(FadeOutState({r = 255, g = 255, b = 255}, 0.2, function()
                    end))
                end))
            end,
            ["text"] = "Start",
            ["font"] = gFonts['medium-bigger']
        },
        {
            ["text"] = "Number of players",
            ["arrowFunction"] = function(incr)
                self.data[2].value = scaleIncrement(self.data[2].value, 1, MAX_PLAYERS, incr)
            end,
            ["enter"] = function() end,
            ["font"] = gFonts['medium-smaller'],
            ["value"] = 2
        },
        {
            ["text"] = "Level",
            ["arrowFunction"] = function(incr)
                self.data[3].value = scaleIncrement(self.data[3].value, 1, NUM_LEVELS, incr)
            end,
            ["enter"] = function() end,
            ["font"] = gFonts['medium-smaller'],
            ["randomval"] = NUM_LEVELS,
            ["value"] = 2
        },
        {
            ["text"] = "Go back",
            ["arrowFunction"] = function(incr) end,
            ["enter"] = function()
                Timer.tween(0.25, {
                    [self.colors['panel']] = {[4] = 0},
                    [self.colors['text']] = {[4] = 0},
                    [self.colors['background']] = {[4] = 0}
                }):finish(function() gStateStack:pop() end)
            end,
            ["font"] = gFonts['medium-bigger'],
        },
    }
    self.highlighted = 0
end

function LevelSelectState:update(dt)
    if love.keyboard.wasPressed('escape') then
        Timer.tween(0.25, {
            [self.colors['panel']] = {[4] = 0},
            [self.colors['text']] = {[4] = 0},
            [self.colors['background']] = {[4] = 0}
        }):finish(function() gStateStack:pop() end)
    end

    if love.keyboard.wasPressed('up') then
        self.highlighted = (self.highlighted - 1)%#self.data
    end

    if love.keyboard.wasPressed('down') then
        self.highlighted = (self.highlighted + 1)%#self.data
    end

    if love.keyboard.wasPressed('return') then
        self.data[self.highlighted + 1].enter()
    end

    if love.keyboard.wasPressed('right') then
        self.data[self.highlighted + 1].arrowFunction(1)
    end

    if love.keyboard.wasPressed('left') then
        self.data[self.highlighted + 1].arrowFunction(-1)
    end
end

function LevelSelectState:render()
    -- transluscent background
    love.graphics.setColor(self.colors['background'])
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(self.colors['panel'])
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 10)

    local y = self.y

    for i, object in pairs(self.data) do
        if i == self.highlighted + 1 then
            love.graphics.setColor(200, 0, 0, self.colors['text'][4])
        else
            love.graphics.setColor(self.colors['text'])
        end
        love.graphics.setFont(object.font)
        love.graphics.printf(object.text, self.x, y, self.width, 'center')
        if object.value then
            object.value = object.value == object.randomval and 'random' or object.value
            y = y + object.font:getHeight()
            love.graphics.printf(object.value, self.x, y, self.width, 'center')

            local width = 20
            local x = self.x + (self.width - object.font:getWidth(tostring(object.value))) / 2 - 3 * width
            love.graphics.polygon('fill', {x, y + object.font:getHeight() / 2, x + width, y, x + width, y + object.font:getHeight()})

            local x = self.x + (self.width + object.font:getWidth(tostring(object.value))) / 2 + 2 * width
            love.graphics.polygon('fill', {x + width, y + object.font:getHeight() / 2, x, y, x, y + object.font:getHeight()})
            object.value = object.value == 'random' and NUM_LEVELS or object.value
        end

        y = y + object.font:getHeight() * 1.5
    end
end
