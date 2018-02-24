--------------------------------------------------------------------------------
_G.CHERRY_VERSION = '2.7.0-alpha'
--------------------------------------------------------------------------------
-- debug
require 'cherry.libs.logger'

-- libs extensions
require 'cherry.libs.math'
require 'cherry.libs.string'
require 'cherry.libs.table'

--------------------------------------------------------------------------------
-- corona
_G.composer = _G.composer or require 'composer'

-- app
_G.App     = require 'cherry.core.app'
_G.Router  = require 'cherry.core.router'

-- engine
_G.Camera  = require 'cherry.engine.camera'
_G.Effects = require 'cherry.engine.effects'
_G.Game    = require 'cherry.engine.game'
_G.Sound   = require 'cherry.engine.sound'

