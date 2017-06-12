--------------------------------------------------------------------------------

local _          = require 'underscore'
local Background = require 'components.background'
local Screen     = require 'components.screen'
local Effects    = require 'engine.effects'

--------------------------------------------------------------------------------

local physics = require( 'physics' )

--------------------------------------------------------------------------------

local Game = {
    RUNNING = 1,
    STOPPED = 2
}

--------------------------------------------------------------------------------

function Game:new(extension)
    local game = _.extend({
        state = Game.STOPPED
    }, extension)

    setmetatable(game, { __index = Game })
    return game
end

--------------------------------------------------------------------------------

function Game:start()
    self:reset()
    if (self.load) then
        local success = self:load()
        if(success) then
            self:run()
        else
            print('could not load properly')
            self:onLoadFailed()
        end
    else
        self:run()
    end
end

function Game:run()
    self.state = Game.RUNNING

    physics.start()
    physics.setGravity( App.xGravity, App.yGravity )

    Camera:resetZoom()
    Camera:center()
    Camera:start()

    App.score:createBar()
    Background:darken()

    if(self.onRun) then self:onRun() end -- from extension

    if(_G.CBE) then Effects:restart() end
    print('Game runs!')
end

function Game:reset()
    if(self.onReset) then self:onReset() end -- from extension
    Camera:empty()
    App.score:reset()
end

------------------------------------------

function Game:stop(userExit)
    if(self.state == Game.STOPPED) then return end
    self.state = Game.STOPPED

    ------------------------------------------

    if(self.onStop) then self:onStop(userExit) end -- from extension

    ------------------------------------------

    if(not userExit) then
        Screen:showBands()
        App.score:display()
    end

    ------------------------------------------

    Background:lighten()
    if(_G.CBE) then Effects:stop(true) end
    Camera:stop()
end

--------------------------------------------------------------------------------

return Game
