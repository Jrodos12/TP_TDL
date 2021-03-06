--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    gSounds['music']:stop()
    gSounds['boss-music']:stop()
    gSounds['heart']:stop()
    gSounds['game-over']:play()

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['game-over']:stop()
        gSounds['music']:setLooping(true)
        gSounds['music']:play()
                gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end,
        ['game-finished'] = function() return GameFinishedState() end
    }
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    
    love.graphics.setFont(gFonts['Triforce'])
    love.graphics.setColor(196/255, 8/255, 52/255, 240/255)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf('Press Escape to Quit', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(12/255, 98/255, 237/255, 1)
end
