StartState = Class{__includes = BaseState}

function StartState:init()
    self.highlighted = 0
    self.options = {"Play", "Help", "Highscores"}
end

function StartState:update(dt)
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
            gStateStack:pop()
            gStateStack:push(PlayState(3))
        end
    end
end

function StartState:render()
    love.graphics.clear(240, 240, 255, 240)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 200)

    for i, option in ipairs(self.options) do
        if self.highlighted + 1 == i then
            love.graphics.setColor(255, 0, 0, 200)
            font = gFonts['medium-bigger']
        else
            love.graphics.setColor(0, 0, 0, 200)
            font = gFonts['medium']
        end
        love.graphics.setFont(font)
        love.graphics.printf(option, 0, VIRTUAL_HEIGHT/2 + (i-1)*1.5*gFonts['medium']:getHeight(), VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf("PENTALINK", 0, VIRTUAL_HEIGHT / 2 - gFonts['large']:getHeight(), VIRTUAL_WIDTH, 'center')
end
