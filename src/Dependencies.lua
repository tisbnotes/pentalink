Class = require 'lib/class'
push = require 'lib/push'
Event = require 'lib/knife.event'
Timer = require 'lib/knife.timer'

require 'src/Util'
require 'src/Graph'
require 'src/constants'
require 'src/MathFunctions'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/game/StartState'
require 'src/states/game/PlayState'

gFonts = {
    ['small'] = love.graphics.newFont('fonts/Antaro.ttf', 20),
    ['medium'] = love.graphics.newFont('fonts/Antaro.ttf', 40),
    ['medium-bigger'] = love.graphics.newFont('fonts/Antaro.ttf', 50),
    ['large'] = love.graphics.newFont('fonts/Antaro.ttf', LARGE_FONT_SIZE)
}

gSounds = {
    ['menu-select'] = love.audio.newSource('sounds/menu_select.wav'),
    ['deny-connection'] = love.audio.newSource('sounds/deny_connection.wav')
}
