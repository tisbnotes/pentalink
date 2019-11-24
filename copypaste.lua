local numplayers = gStateStack.states[#gStateStack.states].data[2].value
local level = gStateStack.states[#gStateStack.states].data[3].value

gStateStack:push(
    LevelSelectState(
        {
            {
                ['text'] = "GO!",
                ['arrowFunction'] = function(incr) end,
                ['enter'] = function() end,
                ["font"] = gFonts['medium-bigger'],
            }
        }
    )
)




gStateStack:pop()
gStateStack:pop()
gStateStack:push(PlayState(numplayers, level))
gStateStack:push(FadeOutState({r = 255, g = 255, b = 255}, 0.2, function() end))
