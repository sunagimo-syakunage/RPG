# require 'dxopal'
# include DXOpal
# require_remote './rb/skill.rb'
# require_remote './rb/character.rb'
# require_remote './rb/battle.rb'
# require_remote './rb/texts.rb'
# require_remote './rb/ui.rb'
# require_remote './rb/scene.rb'
require 'dxruby'
require_relative './rb/skill.rb'
require_relative './rb/character.rb'
require_relative './rb/battle.rb'
require_relative './rb/texts.rb'
require_relative './rb/ui.rb'
require_relative './rb/scene.rb'
WindowSetting.window_size_preset
Window.loop do
end
