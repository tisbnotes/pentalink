StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = BackgroundState(1)
    self.highlighted = 0
    self.options = {
        {
            ["text"] = "Play",
            ["enter"] = function() gStateStack:push(LevelSelectState()) end
        },
        {
            ["text"] = "Rules",
            ["enter"] = function() gStateStack:push(HelpState()) end
        }
    }
end

function StartState:update(dt)
    self.background:update()
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('up') then
        self.highlighted = (self.highlighted - 1) % #self.options
        gSounds['menu-select']:play()
    end

    if love.keyboard.wasPressed('down') then
        self.highlighted = (self.highlighted + 1) % #self.options
        gSounds['menu-select']:play()
    end

    if love.keyboard.wasPressed('return') then
        self.options[self.highlighted + 1].enter()
    end

    if love.mouse.keysPressed[1] then
        mouseX, mouseY = push:toGame(love.mouse.getX(), love.mouse.getY())
        for i, object in pairs(self.options) do
            font = object.font or gFonts['medium']

            local object_y = VIRTUAL_HEIGHT / 2 + (i - 1) * 1.5 * font:getHeight()
            local object_width = font:getWidth(object.text)
            local object_height = font:getHeight()
            local object_x = 0 + VIRTUAL_WIDTH/2 - object_width/2
            local v = {object_x, object_y, object_x + object_width, object_y, object_x + object_width, object_y + object_height, object_x, object_y + object_height}

            if pointInPolygon({mouseX, mouseY}, v) then
                object.enter()
                break
            end
        end
    end
end

function StartState:render()
    love.graphics.clear(255, 255, 255, 50)

    self.background:render()
    love.graphics.setColor(255, 255, 255, 150)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 200)

    for i, object in pairs(self.options) do
        font = object.font or gFonts['medium']
        if self.highlighted + 1 == i then
            love.graphics.setColor(255, 0, 0, 200)
        else
            love.graphics.setColor(0, 0, 0, 200)
        end
        love.graphics.setFont(font)
        love.graphics.printf(object.text, 0, VIRTUAL_HEIGHT / 2 + (i - 1) * 1.5 * font:getHeight(), VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf("PENTALINK", 0, VIRTUAL_HEIGHT / 2 - gFonts['large']:getHeight(), VIRTUAL_WIDTH, 'center')
end
