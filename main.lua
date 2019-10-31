require 'src/Dependencies'

function love.load()
    love.physics.setMeter(METRE_LENGTH)
    love.window.setTitle('Pentalink')
    love.graphics.setDefaultFilter('linear', 'linear')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.mousepressed(x, y, button, istouch)
    love.mouse.keysPressed[button] = true
end


function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
