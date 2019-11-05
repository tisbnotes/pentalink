StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = BackgroundState(1)
    self.highlighted = 0
    self.options = {"Play", "Help", "Highscores"}
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
        if self.highlighted == 0 then
            gStateStack:push(LevelSelectState())
        elseif self.highlighted == 1 then
            gStateStack:push(HelpState())
        end
    end
end

function StartState:render()
    love.graphics.clear(255, 255, 255, 50)

    self.background:render()
    love.graphics.setColor(255, 255, 255, 150)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- love.graphics.setColor(245, 245, 245, 255)
    -- local width = gFonts['medium']:getWidth('Highscores')
    -- local height = (#self.options)*1.5*gFonts['medium']:getHeight()
    -- local x = (VIRTUAL_WIDTH - gFonts['medium']:getWidth('Highscores'))/2
    -- local y = VIRTUAL_HEIGHT/2
    -- love.graphics.rectangle('fill', x, y, width, height, 10)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 200)

    for i, option in ipairs(self.options) do
        font = gFonts['medium']
        if self.highlighted + 1 == i then
            love.graphics.setColor(255, 0, 0, 200)
        else
            love.graphics.setColor(0, 0, 0, 200)
        end
        love.graphics.setFont(font)
        love.graphics.printf(option, 0, VIRTUAL_HEIGHT/2 + (i-1)*1.5*gFonts['medium']:getHeight(), VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf("PENTALINK", 0, VIRTUAL_HEIGHT / 2 - gFonts['large']:getHeight(), VIRTUAL_WIDTH, 'center')
end
